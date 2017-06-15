//
//  geoPointer.swift
//  mapitout
//
//  Created by Becky Chan on 6/15/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit
import MapKit

class geoPointer: NSObject, MKAnnotation {
    var identifier = "geoPointer"
//    let pawTracker: UIImage = #imageLiteral(resourceName: "paw")
    var coordinate: CLLocationCoordinate2D

    init(lat:CLLocationDegrees,long:CLLocationDegrees){
        coordinate = CLLocationCoordinate2DMake(lat, long)
 
    }

}

//class geoPointerList: NSObject {
//    var geoPoints = [geoPointer]()
//    override init(){
//        geoPoints += geoPointer.provideImageData(UnsafeMutableRawPointer, bytesPerRow: Int, origin: Int, Int, size: Int, Int, userInfo: Any?)
//
//    }
//}
