//
//  ViewController.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/26/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!
    
    var centerCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // recover map center
        let defaults = UserDefaults.standard
        if let latitude = defaults.object(forKey: Key.mapCenterLatitude.rawValue) as? Double,
           let longitude = defaults.object(forKey: Key.mapCenterLongitude.rawValue) as? Double {
            mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
        }
            
    }
    
    
}

