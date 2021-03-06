//
//  Card+CoreDataClass.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/28/22.
//
//

import Foundation
import CoreData
import UIKit

@objc(Card)
public class Card: NSManagedObject {

    //MARK: - custom properties
    var photoDownload: PhotoDownload?
    var saveNotificationObserverToken: Any?
    var image: UIImage?
    var viewController: UIViewController?
    var context: NSManagedObjectContext?
    var changed = false
    var delete = false
    
    deinit {
        removeSaveNotificationObserver()
    }
}
