//
//  MapViewController+Utilities.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation
import MapKit

extension MapViewController {
    func navigateToMapDetailView(view: MKAnnotationView) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let PhotoAlbumViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as! PhotoAlbumViewController
        PhotoAlbumViewController.location = (view.annotation as! AnnotationWithLocation).location
        PhotoAlbumViewController.dataController = dataController
        
        self.navigationController?.pushViewController(PhotoAlbumViewController, animated: true)
    }
}
