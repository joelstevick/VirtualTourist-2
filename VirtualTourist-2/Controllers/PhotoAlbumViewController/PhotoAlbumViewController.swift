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
    var photoUrls = [String]()
    
    var photoDownloads: [PhotoDownload]?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoAlbumCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: PhotoAlbumCollectionViewCell.identifier)
        
        // restore the map center and zoom
        restoreMap(mapView: mapView, centerCoordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        
        // display a pin for this location
        let annotation = MKPointAnnotation()
        annotation.title = location.title
        annotation.subtitle = location.subtitle
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        self.mapView.addAnnotation(annotation)
        
        // collectionView flow layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Constants.sideLength, height: Constants.sideLength)
        collectionView.collectionViewLayout = layout
        
        activityIndicator.startAnimating()
        // download the images
        Task {
            // get the photo URLs
            photoUrls = await getPhotoUrls(coordinate: annotation.coordinate, viewController: self)
            
            // instantiate downloads
            self.photoDownloads = photoUrls.map({ url in
                return PhotoDownload(url: url, collectionView: self.collectionView, viewController: self)
            })
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            collectionView.reloadData()
        }

    }
    
}
