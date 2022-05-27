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
        
        restoreMap(mapView: mapView)
    }
    

}
