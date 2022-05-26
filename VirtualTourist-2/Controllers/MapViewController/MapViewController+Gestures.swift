//
//  MapViewController+Gestures.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/26/22.
//

import Foundation
import UIKit
import CoreLocation

extension MapViewController: UIGestureRecognizerDelegate {
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            // Add a Pin as soon as the user has pressed for > 1= second, don't wait for release
            DispatchQueue.main.async {
                
                // convert the device touch point to a coordinate
                let touchPoint = gestureRecognizer.location(in: self.mapView)
                
                let touchMapCoordinate =  self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
               
                let geoCoder = CLGeocoder()
                
                // get the placemark that describes the location in human-terms
                geoCoder.reverseGeocodeLocation(CLLocation(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)) { (placemarks, error) in
                    guard
                        let placemarks = placemarks,
                        let placeMark = placemarks.first
                    else {
                        return
                    }
                    
                    DispatchQueue.main.async { [weak self]  in
                        
                        // add the pin to the view model
                        self?.addAnnotation(
                            title: placeMark.locality ?? "unnamed locality",
                            subTitle: placeMark.administrativeArea ?? "unnamed administrative area",
                            latitude: touchMapCoordinate.latitude,
                            longitude: touchMapCoordinate.longitude
                        )
                    }
                    
                }
            }
        }
    }

}
