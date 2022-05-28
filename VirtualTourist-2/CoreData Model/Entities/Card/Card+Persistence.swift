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
        
        // load the image from the device
        let fileURL = getFileUrl(cardId: id, viewController: viewController)!
        if let photoImage = UIImage(contentsOfFile: fileURL.path) {
            
            image = photoImage.cgImage
            return true
            
        } else {
            return false
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
        changed = true
        NotificationCenter.default.post(name: Notification.Name(Constants.cardChanged), object: nil)
    }
    
    func handleSaveNotification(notification: Notification) {
        // do nothing, if not changed
        guard changed else {
            return
        }
        changed = false
        // first save to the device in case the db save fails
        saveImage(card: self, viewController: self.viewController!)
        
        do {
            print("id", id)
            try context?.save()
        } catch {
            // TODO: cleanup the saved image
            showError(viewController: viewController!, message: error.localizedDescription)
        }
    }
    
    func markForDelete() {
        delete = true
        
        publishChangeEvent()
    }
}
