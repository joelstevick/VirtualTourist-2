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
    
    let dataController = DataController(modelName: "VirtualTourist_2")
    
    var saveObserverToken: Any?
    
    var savedAnnotations: [AnnotationWithLocation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // recover map center
        let defaults = UserDefaults.standard
        if let latitude = defaults.object(forKey: Key.mapCenterLatitude.rawValue) as? Double,
           let longitude = defaults.object(forKey: Key.mapCenterLongitude.rawValue) as? Double
        {
            restoreMap(mapView: mapView, centerCoordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
        
        // init db
        dataController.load {
            // update to Main
        }
        
        // Setup longpress for MapView
        let lpgr = UILongPressGestureRecognizer(target: self,
                                                action:#selector(self.handleLongPress))
        lpgr.minimumPressDuration = 1
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        
        self.mapView.addGestureRecognizer(lpgr)
        
        // listen for model changes
        addSaveNotificationObserver()
        
        // initialize the view model
        load()
            
    }
    
    
}

