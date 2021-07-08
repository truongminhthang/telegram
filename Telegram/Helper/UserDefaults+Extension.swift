//
//  UserDefaults+Extension.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//


import Foundation

extension UserDefaults {
    func load<T: Codable>(withKey key: String, type: T.Type) -> T? {
        let userDefault = UserDefaults.standard
        switch type {
        case is String.Type:
            return userDefault.string(forKey: key) as? T
        case is Int.Type:
            return userDefault.integer(forKey: key) as? T
        case is Double.Type:
            return userDefault.double(forKey: key) as? T
        case is Float.Type:
            return userDefault.float(forKey: key) as? T
        case is Data.Type:
            return userDefault.data(forKey: key) as? T
        case is URL.Type:
            return  userDefault.url(forKey: key) as? T
        case is [String].Type:
            return userDefault.stringArray(forKey: key) as? T
        case is Bool.Type:
            return userDefault.bool(forKey: key) as? T
            
        default:
            if let data = userDefault.object(forKey: key) as? Data {
                return try? JSONDecoder().decode(T.self, from: data)
            } else {
                return nil
            }
        }
        
    }
    @discardableResult
    func save<T: Codable>(withKey key: String, value: T?, file: String = #file, function: String = #function, line: Int = #line) -> Bool {
        guard let value = value else {return false}
        let userDefault = UserDefaults.standard
        switch value {
        case is String:
            userDefault.set( value as! String, forKey: key)
        case is Int:
            userDefault.set( value as! Int, forKey: key)
        case is Double:
            userDefault.set( value as! Double, forKey: key)
        case is Float:
            userDefault.set( value as! Float, forKey: key)
        case is Data:
            userDefault.set( value as! Data, forKey: key)
        case is URL:
            userDefault.set( value as? URL, forKey: key)
        case is [String]:
            userDefault.set( value as! [String], forKey: key)
        case is Bool:
            userDefault.set( value as! Bool, forKey: key)
            
        default:
            if let encodeData = try? JSONEncoder().encode(value) {
                userDefault.set(encodeData, forKey: key)
            } else {
                
            }
        }
        UserDefaults.standard.synchronize()
        Log.success(file: file, function: function, line: line,items: ["Save", value, "to key", key,  "success!"])
        return true
        
    }
}

