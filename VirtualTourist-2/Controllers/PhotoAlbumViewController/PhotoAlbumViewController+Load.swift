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
        await downloadPhotos(from: location, viewController: self, completion: completion);
    }
}
