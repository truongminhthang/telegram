//
//  MainView.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import UIKit

class MainView: View {
   
    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        presenter = MainPresenter(view: self)
    }
    
    @IBAction private func logOut(sender: Any) {
        presenter.logOut()
    }
    
    
}
