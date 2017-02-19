//
//  House.swift
//  HouseMe
//
//  Created by Patrick Chao on 2/18/17.
//  Copyright © 2017 ChaoHaoBerkeley. All rights reserved.
//

import Foundation

class House {
    var location = CLLocationCoordinate2D()
    var description = String()
    
    
    init (location: CLLocationCoordinate2D, description: String){
        self.location=location
        self.description=description
    }
}
