//
//  MapViewController+CoreData+Notifications.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation

extension MapViewController {
    
    // MARK: - Save Observer
    func addSaveNotificationObserver() {
        
        removeSaveNotificationObserver()
        
        saveObserverToken =
        NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextDidSave,
            object:dataController.viewContext,
            queue:nil,
            using:handleSaveNotication(notification:))
        
    }
    func removeSaveNotificationObserver() {
        if let token = saveObserverToken {
            NotificationCenter.default.removeObserver(token)
            
            saveObserverToken = nil
        }
    }
    func handleSaveNotication(notification: Notification) {
       
        DispatchQueue.main.async { [weak self] in
            // clear the map
            if let savedAnnotations = self?.savedAnnotations {
                self?.mapView.removeAnnotations(savedAnnotations)
            }
            // reload the map
            self?.load()
        }
    }
    
}
