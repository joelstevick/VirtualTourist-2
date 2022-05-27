//
//  PhotoAlbumCollectionViewCell.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import UIKit

class PhotoAlbumCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoAlbumCollectionViewCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(image: UIImage?, loading: Bool) {
        imageView.image = image
        imageView.isHidden = loading
        
        activityIndicator.isHidden = !loading
            
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PhotoAlbumCollectionViewCell", bundle: nil)
    }
}
