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
    var photoInfo = [PhotoInfo]()
    var cards: [Card]?
    
    @IBOutlet weak var noPicsLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noPicsLabel.isHidden = true
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
            photoInfo = await getPhotoUrls(coordinate: annotation.coordinate, viewController: self)
            
            // load the cards
            self.cards = photoInfo.map({ info in
                
                // initialize a card.  Inject the photo downloader, in case it is needed
                let card = Card(context: dataController.viewContext)
                card.photoDownload = PhotoDownload(url: info.url, collectionView: self.collectionView, viewController: self, id: info.id)
                
                card.load(context: dataController.viewContext, viewController: self)
                
                return card
            })
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                if self.cards?.count == 0 {
                    self.noPicsLabel.isHidden = false
                }
            }
            collectionView.reloadData()
        }

    }
    
}
