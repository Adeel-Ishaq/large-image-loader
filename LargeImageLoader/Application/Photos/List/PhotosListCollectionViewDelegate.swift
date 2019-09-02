//
//  PhotosListCollectionViewDelegate.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension PhotosListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photosCell = PhotosCell.deque(from: collectionView, at: indexPath)
        let imageViewSize = photosCell.imageView.bounds.size
        let scale = collectionView.traitCollection.displayScale
        let fetchPhoto = viewModel.fetchImage(for: indexPath.row, size: imageViewSize, scale: scale)
        let cacheKey = viewModel.imageURL(for: indexPath.row)?.absoluteString ?? ""
        photosCell.setup(with: cacheKey, title: "\(indexPath.row)", fetchPhoto: fetchPhoto)
        return photosCell
    }
}

// MARK: - UICollectionViewDelegate

extension PhotosListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectImage(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension PhotosListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let photosCell = collectionView.visibleCells.first as? PhotosCell {
                let imageViewSize = photosCell.imageView.bounds.size
                let scale = collectionView.traitCollection.displayScale
                _ = viewModel.fetchImage(for: indexPath.row, size: imageViewSize, scale: scale, showImage: false)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = (collectionView.frame.width / columns) - (cellInset * 2)
        return CGSize(width: dimension, height: dimension)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: cellInset,
                            bottom: 0,
                            right: cellInset)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellInset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellInset
    }
}
