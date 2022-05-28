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
    var cards = [Card]()
    var changeEventObserverToken: Any?
    
    // MARK: - Outlets
    @IBOutlet weak var noPicsLabel: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Actions
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        publishSaveEvent()
    }
    // MARK: - Lifecyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn.isEnabled = false
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
        
        // listen for change events: enable save button
        changeEventObserverToken = NotificationCenter.default.addObserver(forName: Notification.Name(Constants.cardChanged),                                                                         object: nil, queue: nil, using: handleChangeNotification)
        
        // download the images
        Task {
            // do we already have cards?
            if location.cards?.count != 0 {
                cards.removeAll()
                
                for _card in location.cards! {
                    cards.append(_card as! Card)
                    
                    let card: Card = _card as! Card
                    
                    card.load(context: dataController.viewContext, viewController: self)
                    
                }

                collectionView.reloadData()
                activityIndicator.stopAnimating()
            } else {
                // get the photo URLs
                photoInfo = await getPhotoUrls(coordinate: annotation.coordinate, viewController: self)
                
                // load the cards
                self.cards = photoInfo.map({ info in
                    
                    // initialize a card.  Inject the photo downloader, in case it is needed
                    let card = Card(context: dataController.viewContext)
                    card.photoDownload = PhotoDownload(url: info.url, collectionView: self.collectionView, viewController: self, id: info.id)
                    
                    card.id = String(info.id)
                    card.location = location
                    
                    card.load(context: dataController.viewContext, viewController: self)
                    
                    return card
                })
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                    if self.cards.count == 0 {
                        self.noPicsLabel.isHidden = false
                    }
                }
            }
        }
    }
    deinit {
        removeChangesNotificationObserver()
    }
    
    // MARK: - Notification handling
    func removeChangesNotificationObserver() {
        if let token = changeEventObserverToken {
            NotificationCenter.default.removeObserver(token)
            
            changeEventObserverToken = nil
        }
    }
    
    func handleChangeNotification(notification: Notification) {
        saveBtn.isEnabled = true
    }
    
    private func publishSaveEvent() {
        NotificationCenter.default.post(name: Notification.Name(Constants.save), object: nil)
        
        saveBtn.isEnabled = false
    }
}
