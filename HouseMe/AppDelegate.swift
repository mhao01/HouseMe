//
//  AppDelegate.swift
//  HouseMe
//
//  Created by Patrick Chao on 2/17/17.
//  Copyright © 2017 ChaoHaoBerkeley. All rights reserved.
//

import UIKit
import GooglePlacePicker
import GooglePlaces
import GoogleMaps
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    // 1
    let googleMapsApiKey = "AIzaSyAKVInqf_O3Sqm7aZoXmTCm2IWjomkYIr0"
    
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // 2
                GMSServices.provideAPIKey("AIzaSyAKVInqf_O3Sqm7aZoXmTCm2IWjomkYIr0")
        GMSPlacesClient.provideAPIKey("AIzaSyAKVInqf_O3Sqm7aZoXmTCm2IWjomkYIr0")
        return true

    }
    override init() {
        super.init()
        FIRApp.configure()
        // not really needed unless you really need it FIRDatabase.database().persistenceEnabled = true
    }
    
}
