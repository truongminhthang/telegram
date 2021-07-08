//
//  UIResponder+Extension.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import UIKit
private weak var currentFirstResponder: AnyObject?
extension UIResponder {
    
    static func firstResponder() -> AnyObject? {
        currentFirstResponder = nil
        // さんをターゲットに設定することにより、システムが自動的に反応連鎖探索
        // ようは、応答がチェーンの最初の応答者は、カスタムメイドの方法に応じます。
        UIApplication.shared.sendAction(#selector(findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return currentFirstResponder
    }
    
    @objc func findFirstResponder(_ sender: AnyObject) {
        // 最初の応答者はこの方法に応じて、静的変数currentfirstresponder自身を設定します。
        currentFirstResponder = self
    }
    
    static func getFirstResponder() -> AnyObject? {
        return firstResponder()
    }
}
