//
//  Dequeable.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

protocol Dequeable {}

extension Dequeable {
    
    static func deque(from collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        let indentifier = String(describing: Self.self)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath) as? Self {
            return cell
        }
        fatalError("could not deque collection view cell with identifier (\(indentifier))")
    }
}

