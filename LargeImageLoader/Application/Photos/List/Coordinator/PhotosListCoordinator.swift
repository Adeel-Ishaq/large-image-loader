//
//  PhotosListCoordinator.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

protocol PhotosListCoordinatorDelegate: class {
}

final class PhotosListCoordinator: Coordinator {
    
    // MARK: - Properties
    var children = [Coordinator]()
    var root: UIViewController!
    
    init(_ controller: UIViewController) {
        self.root = controller
    }
    
    func start() {
        guard let root = root as? UINavigationController else { return }
        let vm = PhotosListViewModel()
        vm.coordinatorDelegate = self
        let vc = PhotosListViewController(with: vm)
        root.viewControllers = [vc]
    }
    
//    func prepareGalleryDetail(_ root: UIViewController, gallery: Gallery) {
//        let c = GalleryDetailsCoordinator(root, gallery: gallery)
//        c.parent = self
//        c.start()
//        children.append(c)
//    }
}

// MARK: - PhotosListCoordinatorDelegate

extension PhotosListCoordinator: PhotosListCoordinatorDelegate {
}
