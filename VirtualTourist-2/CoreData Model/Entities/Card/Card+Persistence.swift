//
//  Card+Persistence.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/28/22.
//

import Foundation
import CoreData
import UIKit

extension Card {
    
    func load(context: NSManagedObjectContext, viewController: UIViewController) {
        if !loadFromDevice(context: context, viewController: viewController) {
            if image == nil {
                photoDownload?.download()
            }
        }
    }
    
    func loadFromDevice(context: NSManagedObjectContext, viewController: UIViewController) -> Bool {
        return false
    }
    
    func getImage() -> CGImage? {
        if let image = image {
            return image
        } else {
            return photoDownload?.croppedImage
        }
    }
}
