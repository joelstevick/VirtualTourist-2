//
//  PhotoDownload.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import UIKit

class PhotoDownload {
    let url: String
    let collectionView: UICollectionView
    let viewController: UIViewController
    var image: UIImage?
    
    init(url: String, collectionView: UICollectionView, viewController: UIViewController) {
        self.url = url
        self.collectionView = collectionView
        self.viewController = viewController
        
        download()
    }
    
    func download() {
        Task {
            // download the image
            image = await fetchImage(photoUrl: URL(string: self.url)!,
                                              viewController: self.viewController)
            
            // update the collection view
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
}