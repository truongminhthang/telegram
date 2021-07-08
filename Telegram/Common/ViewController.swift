//
//  ViewController.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import UIKit

class View: UIViewController, ViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapBackground() {
        UIResponder.firstResponder()?.resignFirstResponder()
    }
    
    func getTypeName() -> String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }
    
   

}

class Presenter {
    
    
}

class Interactor {
    
}

protocol ViewProtocol {
    
}
