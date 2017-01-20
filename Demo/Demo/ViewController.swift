//
//  ViewController.swift
//  Demo
//
//  Created by X140Yu on 1/19/17.
//  Copyright © 2017 X140Yu. All rights reserved.
//

import UIKit
import XYVolumeHandler

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        XYVolumeHandler.sharedInstance().startMonitor(true)
        self.xy_setupVolumeView()
    }
}

extension ViewController: XYVolumeHandlerProtocol {
    func needShowVolumeHandlerNotification() -> Bool {
        return true
    }
}
