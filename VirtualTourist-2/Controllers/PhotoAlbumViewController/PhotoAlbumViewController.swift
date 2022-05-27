//
//  PhotoAlbumViewController.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import UIKit
import MapKit

class PhotoAlbumViewController: UIViewController {

    // MARK - Properties
    var location: Location!
    var dataController: DataController!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // restore the map center and zoom
        restoreMap(mapView: mapView, centerCoordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        
        // display a pin for this location
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        self.mapView.addAnnotation(annotation)
    }
    

}
