//
//  RootWireFrame.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import UIKit
import ProgressHUD

class Wireframe {

    var rootNav: UINavigationController? {
        AppDelegate.shared.window?.rootViewController as? UINavigationController
    }
    
    func showError(string: String) {
        ProgressHUD.showFailed(string)
    }
    
    func showSucceed(string: String) {
        ProgressHUD.showSucceed(string)
    }
}


