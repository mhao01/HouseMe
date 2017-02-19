//
//  ViewController.swift
//  HouseMe
//
//  Created by Patrick Chao on 2/17/17.
//  Copyright © 2017 ChaoHaoBerkeley. All rights reserved.
// https://gist.github.com/licvido/55d12a8eb76a8103c753
// http://stackoverflow.com/questions/39310729/problems-with-cropping-a-uiimage-in-swift

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker



class MapViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    var imageDescription = "null"
    //var imageDescriptions = [String]()
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 48.857165, longitude: 2.354613, zoom: 8.0)
        mapView.camera = camera
    }
    
    
    
    
    
    // Show the first image when the app starts
    private func showInitialImage() {
        if let image = UIImage(named: DemoConstants.initialImage.fileName) {
            scrollView.auk.show(image: image,
                                accessibilityLabel: DemoConstants.initialImage.description)
            
            //imageDescriptions.append(DemoConstants.initialImage.description)
        }
    }
    
    /// Animate scroll view on orientation change
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        guard let pageIndex = scrollView.auk.currentPageIndex else { return }
        let newScrollViewWidth = size.width // Assuming scroll view occupies 100% of the screen width
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.scrollView.auk.scrollToPage(atIndex: pageIndex, pageWidth: newScrollViewWidth, animated: false)
            }, completion: nil)
    }
    
    /// Animate scroll view on orientation change
    /// Support iOS 7 and older
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation,
                             duration: TimeInterval) {
        
        super.willRotate(to: toInterfaceOrientation, duration: duration)
        
        var screenWidth = UIScreen.main.bounds.height
        if UIInterfaceOrientationIsPortrait(toInterfaceOrientation) {
            screenWidth = UIScreen.main.bounds.width
        }
        
        guard let pageIndex = scrollView.auk.currentPageIndex else { return }
        scrollView.auk.scrollToPage(atIndex: pageIndex, pageWidth: screenWidth, animated: false)
    }
    
    // MARK: - Image description
    
    private func showCurrentImageDescription() {
        if let description = currentImageDescription {
            imageDescriptionLabel.text = description
        } else {
            imageDescriptionLabel.text = nil
        }
    }
    
    
    
    private var currentImageDescription: String? {
        
        
        return imageDescription
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        showCurrentImageDescription()
    }
    
    
    
    
    
}

