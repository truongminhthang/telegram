//
//  WelcomInteractor.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation
import Firebase


// MARK: - <#Mark#>

extension Repository {
    
    func register(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        FirebaseUserManager().register(email: email, password: password) { [weak self] returnValue in
            guard let self = self else { return}
            switch returnValue {
            case .success(let auth):
                guard let auth = auth else {
                    completion(.failure(TelegramError.nullValue))
                    return
                }
                let pushID = UserDefaults.standard.load(withKey: K.fcm, type: String.self) ?? ""
                let user = User(id: auth.user.uid, username: email, email: email, pushId: pushID, avatarLink: "", status: "")
                User.save(user: user)
                completion(.success(auth))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
    func login(email: String, password: String, completion: @escaping (_ result: Result<Bool, Error>) -> Void) {
        FirebaseUserManager().login(email: email, password: password) {[weak self] returnValue in
            guard let self = self else { return  }
            switch returnValue {
            case .success(let auth):
                if var user = User.current {
                    let pushID = UserDefaults.standard.load(withKey: K.fcm, type: String.self) ?? ""
                    user.pushId = pushID
                    User.save(user: user)
                }
                if auth?.user.isEmailVerified == true {
                    self.downloadUserFromFirebase(userID: auth!.user.uid)
                    completion(.success(auth!.user.isEmailVerified))
                } else {
                    completion(.success(false))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadUserFromFirebase(userID: String) {
        
        
    }
    
    func resendVerificationEmail(email: String, completion: @escaping (Error?) -> Void ) {
        FirebaseUserManager().resendVerificationEmail(email: email, completion: completion)
    }
    
}
