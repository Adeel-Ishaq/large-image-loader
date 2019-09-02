//
//  NSObject+className.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// Returns name of class
    class var className: String {
        return String(describing: self)
    }
}
