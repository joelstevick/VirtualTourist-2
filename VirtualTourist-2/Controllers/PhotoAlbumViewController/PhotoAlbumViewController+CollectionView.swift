//
//  PhotoAlbumViewController+CollectionViewDelegate.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import UIKit

extension PhotoAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAlbumCollectionViewCell.identifier, for: indexPath) as! PhotoAlbumCollectionViewCell
        
        cell.configure(with: nil, loading: true)
        
        return cell
    }
    
}
