//
//  GetFileUrl.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/28/22.
//

import UIKit

func getFileUrl(cardId: String, viewController: UIViewController) -> URL? {
    let manager = FileManager.default
    
    guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        showError(viewController: viewController, message: "Could not get File URL")
        return nil
    }
    // create the card-images folder
    let folderUrl = url.appendingPathComponent(Constants.cardImages)
    
    do {
        try manager.createDirectory(at: folderUrl, withIntermediateDirectories: true)
    } catch {
        showError(viewController: viewController, message: error.localizedDescription)
    }
    
    // file URL
    return folderUrl.appendingPathComponent("\(Constants.cardPrefix)-\(cardId)")
    
}
