//
//  DroppablePin\.swift
//  cover-ma-poi
//
//  Created by Fitri San on 14/09/2019.
//  Copyright © 2019 com.piteli. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DroppablePin : NSObject, MKAnnotation{
    dynamic var coordinate : CLLocationCoordinate2D
    var identifier : String
    
    init(coordinate : CLLocationCoordinate2D, identifier : String){
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}
