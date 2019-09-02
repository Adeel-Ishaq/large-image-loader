//
//  PhotosListViewModel.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

enum StoreResult<T> {
    case success(T)
    case failure(error: Error)
}
typealias StoreCompletion<T> = (StoreResult<T>) -> Void

final class PhotosListViewModel {
    
    weak var coordinatorDelegate: PhotosListCoordinatorDelegate?
    weak var viewDelegate: PhotosListViewDelegate?
    
    let serialQueue = DispatchQueue(label: "Decode Queue")
    let totalPhotos = 29
    private let imageCache = NSCache<NSString, UIImage>()
    private let bundleName = "photos.bundle"
    private let imageFormat = "png"

    // MARK: - Methods
    init() {}
    
    // - MARK: Public methods
    
    /// To inform view model that view has loaded.
    /// View model fetches the view item.
    func viewDidLoad() {
        viewDelegate?.refreshGallery()
    }
    
    /// Fetches image for a cell.
    ///
    /// - Parameter
    ///   - index: index of the cell.
    ///   - size: size of ImageView of cell.
    ///   - scale: scale of ImageView of cell.
    func fetchImage(for index: Int, size: CGSize, scale: CGFloat, showImage: Bool = true) -> ((@escaping StoreCompletion<UIImage>)->Void) {
        return { [weak self] completion in
            guard let `self` = self else {
                return
            }
            if let url = self.imageURL(for: index) {
            let cacheKey = url.absoluteString as NSString
            if let imageFromCache = self.imageCache.object(forKey: cacheKey) {
                if showImage {
                    completion(.success(imageFromCache))
                }
                return
            }
                
            self.serialQueue.async {
                    guard let image = UIImage.downsample(imageAt: url, to: size, scale: scale) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.imageCache.setObject(image, forKey: cacheKey)
                        if showImage {
                            image.accessibilityIdentifier = cacheKey as String
                            completion(.success(image))
                        }
                    }
               }
            }
        }
    }
    
    func imageURL(for index: Int) -> URL? {
        let imagePath = self.bundleName + "/" + "\(index)"
        guard let pathForFile = Bundle.main.path(forResource: imagePath, ofType: self.imageFormat) else {
            return nil
        }
        let imageURL = URL(fileURLWithPath: pathForFile)
        return imageURL
    }
}
