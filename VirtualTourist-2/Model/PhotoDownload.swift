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
    var image: UIImage?
    
    init(url: String, collectionView: UICollectionView) {
        self.url = url
        self.collectionView = collectionView
        
        download()
    }
    
    func download() {
        
    }
}
