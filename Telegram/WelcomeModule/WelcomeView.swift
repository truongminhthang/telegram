//
//  ViewController.swift
//  Telegram
//
//  Created by Thang Truong on 28/06/2021.
//

import UIKit
import FirebaseAuth

class WelcomeView: View {
    
    @IBOutlet private weak var emailTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    
    private var email: String {
      return emailTextfield.text ?? ""
    }
    private var password: String {
        return passwordTextfield.text ?? ""
    }
    
    private var presenter : WelcomePresenter!


    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info()
        presenter = WelcomePresenter(view: self)
        
        // Do any additional setup after loading the view.
    }
    // MARK: - Action
    @IBAction private func onRegister(sender: UIButton) {
        // something
        presenter.onRegister(email: email, password: password)
    }
    
    @IBAction private func onLogin(sender: UIButton) {
        presenter.onLogin(email: email, password: password)
    }
    
    @IBAction private func onResendEmailVerification(sender: UIButton) {
        presenter.onResendEmailVerification(email: email)
        
    }
    
    @IBAction private func onResetPassword(sender: UIButton) {
        presenter.onResetPassword(email: email)
    }
}



