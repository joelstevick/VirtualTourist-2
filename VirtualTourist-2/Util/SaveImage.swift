//
//  SaveImage.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/28/22.
//

import UIKit

func saveImage(
    card: Card,
    viewController: UIViewController
) {
    // persist the image to the filesystem
    let manager = FileManager.default
    
    // save to the file
    if let fileUrl = getFileUrl(cardId: card.id!, viewController: viewController),
       let image = card.getImage() {
        manager.createFile(atPath: fileUrl.path, contents: UIImage(cgImage: image).jpegData(compressionQuality: 1.0))
    } else {
        showError(viewController: viewController, message: "Could not save image to the device")
    }
}
