//
//  MainWireframe.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation

class MainWireframe: Wireframe {
    
    class func setupMainModule(presenter: MainPresenter) {
        presenter.wireframe = MainWireframe()
    }
    
    func logOut() {
        let welcomeView : WelcomeView = getInstance()
        rootNav?.viewControllers = [welcomeView]
    }
}
