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

    public func configure(cgImage: CGImage?, loading: Bool) {
        if let cgImage = cgImage {
            imageView.image = UIImage(cgImage: cgImage)
        }
       
        imageView.isHidden = loading
        
        activityIndicator.isHidden = !loading
            
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PhotoAlbumCollectionViewCell", bundle: nil)
    }
}
