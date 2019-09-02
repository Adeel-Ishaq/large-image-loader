//
//  Coordinator.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

/// Using this protocol can provide de-coupling of navigation
public protocol Coordinator: AnyObject {
    
    // associatedtype RootController: UIViewController
    
    /// List all the sub-coordinators
    var children: [Coordinator] { get set }
    /// Provide a root to perform navigations
    var root: UIViewController! { get set }
    
    /// Boot up the current coordinator
    func start()
    
    /// Clean up the child
    func childDidFinish(_ child: Coordinator)
}

public extension Coordinator {
    
    func childDidFinish(_ child: Coordinator) {
        if let idx = children.firstIndex(where: { $0 === child }) {
            children.remove(at: idx)
        }
    }
}

