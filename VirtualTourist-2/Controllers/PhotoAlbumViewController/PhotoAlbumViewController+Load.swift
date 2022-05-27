//
//  PhotoAlbumViewController+Load.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import Foundation
import CoreLocation
import UIKit

extension PhotoAlbumViewController {
    actor DownloadCounter {
        var count = 0
        func increment() {
            count += 1
        }
    }
    
    func loadFromCloud(completion: (() -> Void)?) async {
        
        // get the photo URLs
        let photoUrls = await photos(
            coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), viewController: self)
        
        guard photoUrls.count > 0 else {
            // call completion handler
            if let completion = completion {
                completion()
                
                showError(viewController: self, message: "No pictures for this location")
            }
            return
        }
        // download the images
        let downloadCounter = DownloadCounter()
        
        for photoUrl in photoUrls {
            DispatchQueue.main.async {
                
                Task {
                    await downloadCounter.increment()
                    
                    // download the image
                    let photoImage = await fetchImage(photoUrl: URL(string: photoUrl)!,
                                                      viewController: self)
                    
                    // add a card the downloaded image
                    if let photoImage = photoImage {
                        
                        // If all images downloaded, we are done
                        if await downloadCounter.count == photoUrls.count {
                            
                            print("all images downloaded", photoUrls.count)
                            // call completion handler
                            if let completion = completion {
                                completion()
                            }
                        }
                    }
                }
            }
        }
    }
    
}
