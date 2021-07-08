//
//  Date+Extension.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation
extension Date {
   /**
    書式指定した日付文字列に変換。
    - Parameter format: 書式文字列。デフォルトは"yyyy/MM/dd HH:mm:ss"
    - returns: 書式変換後の日付文字列
    */
   func stringFormat(format: String = "yyyy-MM-dd HH:mm:ss.SSSSSSZ") -> String {
       let formatter: DateFormatter = DateFormatter()
       formatter.dateFormat = format
       // #5531 24時間ファーマット対応 8/31 wangh start
       formatter.locale = NSLocale.system
       // #5531 24時間ファーマット対応 8/31 wangh end
       return formatter.string(from: self)
   }
   
}

