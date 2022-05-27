//
//  CropImage.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import UIKit

func cropImage(_ image: UIImage) -> CGImage {
    // Determines the x,y coordinate of a centered
    // sideLength by sideLength square
    let sourceSize = image.size
    let xOffset = (sourceSize.width - Constants.sideLength) / 2.0
    let yOffset = (sourceSize.height - Constants.sideLength) / 2.0

    // The cropRect is the rect of the image to keep,
    // in this case centered
    let cropRect = CGRect(
        x: xOffset,
        y: yOffset,
        width: Constants.sideLength,
        height: Constants.sideLength
    ).integral

    // Center crop the image
    let sourceCGImage = image.cgImage!
    let croppedCGImage = sourceCGImage.cropping(
        to: cropRect
    )!
    
    return croppedCGImage
}
