//
//  UIImage.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

extension UIImage {

    ///
    /// DownSampling technique to minimise the memory usage
    ///
    /// - Parameters:
    ///   - url: a URL instnace that that specifies the location of an image
    ///   - pointSize: is the target size represented by `CGSize` that you wish to get
    ///   - scale: is the scale factor that is represented by `CGFloat`
    /// - Returns: an optional `UIImage` instnace that holds the downsampled image, or `nil` if either `CGImageSourceCreateWithURL` or `CGImageSourceCreateThumbnailAtIndex` has failed a `guard` statement
    public static func downsample(imageAt url: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions) else { return nil }
        
        let maxDimensionsInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways : true,
            kCGImageSourceShouldCacheImmediately : true,
            kCGImageSourceCreateThumbnailWithTransform : true,
            kCGImageSourceThumbnailMaxPixelSize : maxDimensionsInPixels
            ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { return nil }
        
        return .init(cgImage: downsampledImage)
    }
    
}
