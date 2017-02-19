//
//  UploadViewController.swift
//  
//
//  Created by Patrick Chao on 2/18/17.
//
//

import Foundation
//
//  ViewController.swift
//  HouseMe
//
//  Created by Patrick Chao on 2/17/17.
//  Copyright © 2017 ChaoHaoBerkeley. All rights reserved.
//http://www.codingexplorer.com/choosing-images-with-uiimagepickercontroller-in-swift/
// https://gist.github.com/licvido/55d12a8eb76a8103c753
// http://stackoverflow.com/questions/39310729/problems-with-cropping-a-uiimage-in-swift

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class UploadViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    //MARK: Properties
    // Get a reference to the storage service using the default Firebase App
    let storage = FIRStorage.storage()
    var storageRef: FIRStorageReference?
    let uuid = UUID().uuidString
    var counter = 1
    var numHouses = 0
    let databaseRef = FIRDatabase.database().reference(fromURL: "https://houseme-1487420013800.firebaseio.com/")
    //let databaseRef = FIRDatabase.database().reference(fromURL: "gs://houseme-1487420013800.appspot.com")
    

    weak var sc: SlideshowController?
    // Create a storage reference from our storage service
    let imagePicker = UIImagePickerController()
    
    
    
    //MARK: Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        storageRef = storage.reference().child("myImage.png")
        countHouses()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SlideshowSegue" {
            self.sc = segue.destination as? SlideshowController
        }
    }

    @IBAction func loadImageButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var loadImageButton: UIButton!
    
    func countHouses(){
        FIRDatabase.database().reference().queryOrdered(byChild: "ID").observe(.childAdded, with: { snapshot in
            self.numHouses = Int(snapshot.childrenCount)
            
        })
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    //MARK: UIImageViewController Delegate Functions
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            sc?.addImage(image: pickedImage)
            imagePickerController(picker: picker, didFinishPickingImage: pickedImage, editingInfo: ["test" : "test" as AnyObject])
        }
        if (sc?.images.count)! >= 6 {
            self.loadImageButton.isEnabled = false
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        //print(FIRAuth.auth()!.currentUser)
        //FIRDatabase.database().reference(fromURL: "https://houseme-1487420013800.firebaseio.com/")
        let email = "testEmail@gmail.com"
        let password = "testPassword"
        var values = [ "test " : "test" as AnyObject]
        var URL = "null"
        
        dismiss(animated: true, completion: nil)
        FIRAuth.auth()!.createUser(withEmail: email, password: password)
        
        
        let imageName = "imageURL" + String(self.counter)
        print("\(uuid).png")
        storageRef = FIRStorage.storage().reference().child(String(self.numHouses+1)+"/"+"\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(image){
            storageRef?.put(uploadData, metadata: nil,completion:{(metadata,error) in
                if error != nil {
                    print(error)
                    return
                }
                
                print(metadata)
                
                print(metadata?.downloadURL())
                if let imageURL = metadata?.downloadURL()?.absoluteString{
                    values = ["imageURL" + String(self.counter): imageURL as AnyObject , "ID" : String(self.numHouses + 1) as AnyObject ]
                    self.registerUserIntoDatabaseWithUID(uid: String(self.numHouses + 1),values : values as [String : AnyObject])
                    self.counter = self.counter + 1
                    //URL = imageURL
                }

            })
            
        }
        

        //print(URL)
        //self.registerUserIntoDatabaseWithUID(uid: self.uuid,values : values as [String : AnyObject])
        /**
        var data = NSData()
        data = UIImageJPEGRepresentation(image, 0.8)! as NSData
        // set upload path
        //let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("userPhoto")"
        let filePath = "/\("userPhoto")"
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef?.child(filePath).put(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                //store downloadURL
                let downloadURL = metaData!.downloadURL()!.absoluteString
                //store downloadURL at database
                self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userPhoto": downloadURL])
            }
            
        }
 */
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference(fromURL: "https://houseme-1487420013800.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        })
    }

}
