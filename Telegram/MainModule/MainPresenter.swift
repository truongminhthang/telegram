//
//  MainPresenter.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation



class MainPresenter: Presenter {
    var wireframe : MainWireframe!
    weak var view: MainView!
    
    init(view: MainView) {
        self.view = view
        super.init()
        MainWireframe.setupMainModule(presenter: self)
    }
        
    
    func logOut() {
        Repository.shared.logOut { [weak self] result in
            guard let self = self else { return}
            switch result {
            case.success(let _):
                self.wireframe.logOut()
            case .failure(let error):
                self.wireframe.showError(string: error.localizedDescription)
            }
        }
    }
}
