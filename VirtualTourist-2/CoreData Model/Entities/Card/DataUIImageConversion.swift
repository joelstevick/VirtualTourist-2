//
//  DataUIImageConversion.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/29/22.
//

import UIKit

extension Card {
    
    func imageToData() {
        image = image ?? photoDownload?.image
        
        if let image = image {
            storedImage = image.jpegData(compressionQuality: 1.0)
        }
    }

    func dataToImage() {
        if let storedImage = storedImage {
            image = UIImage(data: storedImage)
        }
        
    }

}
