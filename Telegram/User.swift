//
//  User.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation

struct User: Codable {
    var id = ""
    var username: String
    var email: String
    var pushId = ""
    var avatarLink = ""
    var status: String
    
    static var current: User? {
        return UserDefaults.standard.load(withKey: K.CURRENTUSER, type: User.self)
    }
    
    static func save(user: User) {
        UserDefaults.standard.save(withKey: K.CURRENTUSER, value: user)
        FirebaseUserManager().save(user: user)
    }
    
}

// MARK: - Equatable

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
