//
//  PhotosCell.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell, Dequeable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    private var identifier: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with cacheKey: String, title: String, fetchPhoto: (@escaping StoreCompletion<UIImage>)->Void) {
        titleLabel.text = title
        imageView.image = nil
        identifier = cacheKey
        
        fetchPhoto { [weak imageView] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    if self.identifier == image.accessibilityIdentifier {
                     imageView?.image = image
                    }
                }
            default: break
            }
        }
    }
}
