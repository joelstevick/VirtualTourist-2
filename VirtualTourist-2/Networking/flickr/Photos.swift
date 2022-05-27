//
//  Photos.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import UIKit
import CoreLocation

func getPhotoUrls(coordinate: CLLocationCoordinate2D, viewController: UIViewController) async -> [String] {
    let session = URLSession.shared
    var photoUrls = [String]()
    
    var request = URLRequest(url: URL(string: FlickrConfig.makeSearchUrl(coordinate: coordinate))!)
    request.httpMethod = "GET"
    
    do {
        let (data, _) =  try await session.data(for: request as URLRequest)
//        let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(SearchResponse.self, from: data)
        
        for photo in response.photos.photo {
            
            photoUrls.append(FlickrConfig.makePhotoUrl(photo))
        }
        
        return photoUrls
    } catch {
        print("Error Searching Flickr", error)
        showError(viewController: viewController, message: "Error Searching Flickr \(error)")
        return photoUrls
    }
    
}
