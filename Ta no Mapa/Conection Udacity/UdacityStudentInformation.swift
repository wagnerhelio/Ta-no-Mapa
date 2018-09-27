//
//  UdacityStudentInformation.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 27/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class UdacityStudentInformation {
    
    var FirstName: String?
    var LastName: String?
    var MapString : String?
    var MediaURL : String?
    var Latitude: Double?
    var Longitude: Double?
    
    init(data:[String:AnyObject]) {
        FirstName = data["firstName"] as? String
        LastName = data["lastName"] as? String
        MapString = data["mapString"] as? String
        MediaURL = data["mediaURL"] as? String
        Latitude = data["latitude"] as? Double
        Longitude = data["longitude"] as? Double
    }
    
    init() {}
}
