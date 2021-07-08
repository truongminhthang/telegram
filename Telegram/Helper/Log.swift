//
//  Log.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation

class Log {
    static func info(levelIndicator: String = "", file: String = #file, function: String = #function, line: Int = #line, items: [Any]) {
        let time = Date().stringFormat()
        let itemString = items.map { String(describing: $0) }.joined(separator: " ")
        let filename = file.split(separator: "/").dropFirst(4).joined(separator: "/")
        let content = itemString.count == 0 ? "" : "\t\(itemString)"
        print("\n\(time)\tFile: \(filename) \(function)(line:\(line - 1)) \(levelIndicator)\(content)")
    }
    
    static func info(levelIndicator: String = "", file: String = #file, function: String = #function, line: Int = #line, content: String = "") {
        info(levelIndicator:  "" , file: file, function: function, line: line , items: [content])
    }

    
    static func error(file: String = #file, function: String = #function, line: Int = #line, items: [Any]) {
        info(levelIndicator:  "🔴" , file: file, function: function, line: line , items: items)
    }
    static func error(file: String = #file, function: String = #function, line: Int = #line, content: String = "") {
        info(levelIndicator:  "🔴" , file: file, function: function, line: line , items: [content])
    }
    static func success(file: String = #file, function: String = #function, line: Int = #line, items: [Any]) {
        info(levelIndicator:  "✅" , file: file, function: function, line: line , items: items)
    }
    static func success(file: String = #file, function: String = #function, line: Int = #line, content: String = "") {
        info(levelIndicator:  "✅" , file: file, function: function, line: line , items: [content])
    }
}
