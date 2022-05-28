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
        self.viewController = viewController
        self.context = context
        
        if !loadFromDevice(context: context, viewController: viewController) {
            if image == nil {
                photoDownload?.download()
                
                publishChangeEvent()
            }
        }
        
        // listen for save notifications
        removeSaveNotificationObserver()
        saveNotificationObserverToken = NotificationCenter.default.addObserver(
            forName: Notification.Name(Constants.save),                                                             object: nil, queue: nil, using: handleSaveNotification)
        
    }
    
    func loadFromDevice(context: NSManagedObjectContext, viewController: UIViewController) -> Bool {
    
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "id == %@", id!
        )
        
        do {
            let cards = try context.fetch(fetchRequest)
            
            guard cards.first != nil else {
                return false
            }
            
            // load the image from the device
            let fileURL = getFileUrl(cardId: id!, viewController: viewController)!
            if let photoImage = UIImage(contentsOfFile: fileURL.path) {
                
                image = photoImage.cgImage
                return true
                
            } else {
                return false
            }
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
    // MARK: - Notifications
    func removeSaveNotificationObserver() {
        if let token = saveNotificationObserverToken {
            NotificationCenter.default.removeObserver(token)
            
            saveNotificationObserverToken = nil
        }
    }
    private func publishChangeEvent() {
        NotificationCenter.default.post(name: Notification.Name(Constants.cardChanged), object: nil)
    }
    
    func handleSaveNotification(notification: Notification) {
        // first save to the device in case the db save fails
        saveImage(card: self, viewController: self.viewController!)
        
        do {
            try context?.save()
        } catch {
            // TODO: cleanup the saved image
            showError(viewController: viewController!, message: error.localizedDescription)
        }
    }
}
