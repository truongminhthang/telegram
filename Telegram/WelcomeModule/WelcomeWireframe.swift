//
//  WelcomeWireframe.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import UIKit

class WelcomeWireframe : Wireframe {
        
    func goToApp() {
          let mainView : MainView = getInstance()
          rootNav?.viewControllers = [mainView]
    }
    
    func show() {
        let view : WelcomeView = getInstance()
        rootNav?.isNavigationBarHidden = true
        rootNav?.viewControllers = [view]
    }
    
    class func loadWelcomeComponents(presenter: WelcomePresenter) {
        presenter.wireframe = WelcomeWireframe()
    }
    
    deinit {
        Log.info()
    }
    
    
}

func getInstance<T>(storyboardName: String = "Main") -> T {
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
}
