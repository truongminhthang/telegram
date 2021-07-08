//
//  WelcomePresenter.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation

class WelcomePresenter: Presenter {
    weak var view : WelcomeView!
    var wireframe : WelcomeWireframe!
    
    init(view: WelcomeView) {
        Log.info()
        self.view = view
        super.init()
        WelcomeWireframe.loadWelcomeComponents(presenter: self)
    }
    
    deinit {
        Log.info()
    }
    func onRegister(email: String, password: String) {
        Log.info()
        Repository.shared.register(email: email, password: password) { [weak self] returnValue in
            guard let self = self else { return}
            switch returnValue {
            case .success(let auth):
                Log.success()
                self.wireframe.goToApp()
                
                
            case .failure(let error):
                self.wireframe.showError(string: error.localizedDescription)
            }
        }
    }
    
    
    func onLogin(email: String, password: String) {
        Log.info()
        Repository.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let isEmailVerified):
                if isEmailVerified {
                    self.wireframe.goToApp()
                } else {
                    self.wireframe.showError(string: "Email chua duoc xac thuc")
                }
                
            case .failure(let error):
                self.wireframe.showError(string: error.localizedDescription )
            }
        }
        
    }
    
    func onResendEmailVerification(email: String) {
        Log.info()
        Repository.shared.resendVerificationEmail(email: email) { [weak self] error in
            guard let self = self else { return}
            if error == nil {
                self.wireframe.showSucceed(string: "Valication email is resent to \(email)")
            } else {
                self.wireframe.showError(string: error!.localizedDescription)
            }
        }

    }
    
    func onResetPassword(email: String) {
        Log.info()

    }
}
