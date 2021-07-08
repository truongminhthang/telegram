//
//  MainInteractor.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation

extension Repository {
    func logOut(completion: @escaping (Result<Void, Error>) -> Void) {
        FirebaseUserManager().logOut(completion: completion)
    }
}
