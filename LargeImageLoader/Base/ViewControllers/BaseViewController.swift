//
//  BaseViewController.swift
//  LargeImageLoader
//
//  Created by Tahir Adeel Ishaq on 25.08.19.
//  Copyright © 2019 Adeel-Ishaq. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

