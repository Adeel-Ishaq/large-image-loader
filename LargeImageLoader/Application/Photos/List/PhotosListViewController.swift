//
//  PhotosListViewController.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

protocol PhotosListViewDelegate: class
{
    func refreshGallery()
}

class PhotosListViewController: BaseViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let viewModel: PhotosListViewModel!
    let cellInset: CGFloat = 8
    let columns: CGFloat = 2
    
    init(with viewModel: PhotosListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LargeImageLoader"
        registerCell()
        viewModel.viewDelegate = self
        viewModel.viewDidLoad()
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: PhotosCell.className, bundle: nil),
                                forCellWithReuseIdentifier: PhotosCell.className)
    }
}

// MARK: - PhotosListViewDelegate

extension PhotosListViewController: PhotosListViewDelegate {
    func refreshGallery() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
