//
//  MapViewController+MapKit.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/26/22.
//

import Foundation
import NanoID

extension MapViewController {
    func addAnnotation(
        title: String,
        subTitle: String,
        latitude: Double,
        longitude: Double
    ) {
        
        // persist
        let location = Location(context: dataController.viewContext)
        
        location.id = NanoID.generate()
        location.latitude = latitude
        location.longitude = longitude
        location.title = title
        location.subtitle = subTitle
        location.creationDate = Date.now // we may need this?
        
        do {
            try dataController.viewContext.save()
        } catch {
            showError(viewController: self, message: error.localizedDescription)
        }
    }
    
}
