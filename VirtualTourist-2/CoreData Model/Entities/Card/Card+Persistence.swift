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
    
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "id == %@", id!
        )
        
        do {
            let cards = try context.fetch(fetchRequest)
            
            return (cards.first != nil)
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    func getImage() -> CGImage? {
        if let image = image {
            return image
        } else {
            return photoDownload?.croppedImage
        }
    }
}
