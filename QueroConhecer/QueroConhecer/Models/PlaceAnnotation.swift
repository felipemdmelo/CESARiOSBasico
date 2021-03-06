//
//  PlaceAnnotation.swift
//  QueroConhecer
//
//  Created by Aluno on 15/06/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import Foundation
import MapKit
class PlaceAnnotation: NSObject, MKAnnotation {
    
    enum PlaceType {
        case place
        case poi // pontos de interesse
    }
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: PlaceType
    var address: String?
    
    init(coordinate: CLLocationCoordinate2D, type: PlaceType) {
        self.coordinate = coordinate
        self.type = type
    }
}
