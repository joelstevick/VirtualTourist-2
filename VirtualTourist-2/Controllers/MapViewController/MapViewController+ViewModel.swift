//
//  MapViewController+MapKit.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/26/22.
//

import Foundation
import NanoID
import CoreLocation
import CoreData

extension MapViewController {
    private func addAnnotationToMapView(
        title: String,
        subTitle: String,
        location: Location
    ) {
            let annotation = AnnotationWithLocation()
            
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = title
            annotation.subtitle = subTitle
            annotation.location = location
            
            self.mapView.addAnnotation(annotation)
            
        }
    
    func load() {

        // get the current locations
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        
        // sort reverse chrono
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
    
        guard let locations = try? dataController.viewContext.fetch(fetchRequest) else {
            showError(viewController: self, message: "Could not read your phone data")
            return
        }
        
        for location in locations {
            // display in the map view
            addAnnotationToMapView(
                title: location.title!,
                subTitle: location.subtitle!,
                location: location)
        }        
    }
    
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
