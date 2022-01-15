//
//  CustomAnnotation.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/3/21.
//

import UIKit
import MapKit


struct CustomAnnotation{
    
    var title: String
    var subtitle: String
  
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
    
}
