//
//  ViewController.swift
//  HouseMe
//
//  Created by Patrick Chao on 2/17/17.
//  Copyright © 2017 ChaoHaoBerkeley. All rights reserved.
// https://gist.github.com/licvido/55d12a8eb76a8103c753
// http://stackoverflow.com/questions/39310729/problems-with-cropping-a-uiimage-in-swift

import UIKit
import Foundation
import GooglePlacePicker
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class ViewController: UIViewController, UIScrollViewDelegate, GMSMapViewDelegate {
    
    
    @IBOutlet weak var viewMap: GMSMapView!
    

    var houses = [House]()
    var markers = [GMSMarker]()
    var currentHouse = House(location: CLLocationCoordinate2D(latitude: 37.87, longitude: -122.27),description: "null")
    var numHouses = 0
    

    
    func mapView(_ mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) -> Bool {
        currentHouse = House(location: marker.position, description: marker.snippet!)
        performSegue(withIdentifier: "moveToHouse", sender: nil)
        //let vc = UIStoryboard(name:"HouseViewController", bundle:nil).instantiateViewController(withIdentifier: "identifier") as! HouseViewController
        
        //self.navigationController?.pushViewController(vc, animated:true)
        return true
    }
    
    /**
     func mapView( mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
     
     
     
     print("hi!")
     marker.snippet = "testestest"
     return true
     }
     */
    //  func mapView( _ mapView: GMSMapView!, didTap marker: GMSMarker!) -> Bool {
    
    //    print("yay!!!")
    //  return true
    // }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToHouse" {
            if let vc = segue.destination as? HouseViewController {
                vc.detailHouse = currentHouse
            }
            
            
        }
    }
    func countHouses() {

        FIRDatabase.database().reference().queryOrdered(byChild: "ID").observe(.childAdded, with: { snapshot in
            self.numHouses = Int(snapshot.childrenCount)
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewMap = GMSMapView()
        viewMap.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 37.8719, longitude: -122.2585, zoom: 15.0)
        viewMap.camera = camera
        let databaseRef = FIRDatabase.database().reference(fromURL: "https://houseme-1487420013800.firebaseio.com/")
        countHouses()
        let storage = FIRStorage.storage()
        let storageRef = storage.reference()
        for i in 1...2{
            let localFile = storageRef.child("1/imageURL1.png")
            let localURL = URL(string: "/Users/Patrick/Desktop/HouseMe/HouseMe/Images")!
            let downloadTask = localFile.write(toFile: localURL) { url, error in
                if let error = error {
                    print("darn dude &&&&&&&&&&&&&&&&&&")
                } else {
                    print("YESSSS @@@@@@@@@@@@@@@@@@@@")
                }
            }
        }
        
      /**  usersRef.queryOrderedByChild("age").queryStartingAtValue(20)
            .queryEndingAtValue(25).observeEventType(.Value, withBlock: { snapshot in
                
                for child in snapshot.children { //.Value so iterate over nodes
                    
                    let age = child.value["age"] as! Int
                    let distance = child.value["distance"] as! Int
                    let fbKey = child.key!
                    
                    let u = User(firebaseKey: fbKey, theAge: age, theDistance: distance)
                    
                    userArray.append(u) //add the user struct to the array
                }*/
            
        for houseFields in DemoConstants.houses {
                var house = House(location: CLLocationCoordinate2D(latitude: 37.87, longitude: -122.27),description: "null")
                house.location = houseFields.location
                house.description = houseFields.description
                houses.append(house)
                let marker = GMSMarker(position: house.location)
                //marker.isFlat = true
                //marker.title = "Hello World"
                marker.snippet = house.description
                marker.map = viewMap
                markers.append(marker)
            }
            
        }


    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?.first as! CustomInfoWindow
        infoWindow.price?.text = "Sydney Opera House"
        infoWindow.details?.text = "Bennelong Point Sydney"
        infoWindow.photo?.image = UIImage(named: "Images/1.jpg")
        return infoWindow
    }
    
    
    
}


