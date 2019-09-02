//
//  AppCoordinator.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var children = [Coordinator]()
    var root: UIViewController! {
        get {
            return window.rootViewController
        }
        set {
            window.rootViewController = newValue
        }
    }
    
    weak var window: UIWindow!
    
    init(_ window: UIWindow, start: Bool = false) {
        self.window = window
        if start { self.start() }
    }
    
    func start() {
        showBrowseGallery()
    }
    
    /// Start Gallery Browesing
    func showBrowseGallery() {
        let nav = UINavigationController()
        let c = PhotosListCoordinator(nav)
        c.start()
        children.append(c)
        root = nav
    }
    
}
