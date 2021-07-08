//
//  FirebaseUserManager.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation
import Firebase

class FirebaseUserManager {
    func login(email: String, password: String, completion: @escaping (_ result: Result<AuthDataResult?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {authDataResult, error in
            completedHanlder(authDataResult, error, completion: completion)
        }
    }
    
    func logOut(completion: @escaping (Result<Void, Error>) -> Void) {
        let result = Result {
            try Auth.auth().signOut()
        }
        completion(result)
        
    }

    
    func register(email: String, password: String, completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self]  auth, error in
            guard let self = self else { return}
           
            guard error == nil else {
                completion(.failure(error!))
                Log.error(file: #file, function: #function, content: error!.localizedDescription)
                return
            }
            self.sendEmailVerification(auth: auth!, error: nil, retryCount: 0, completion: completion)
            
        }
    }
    private func sendEmailVerification(auth: AuthDataResult, error: Error? = nil, retryCount: Int = 0, completion: @escaping (Result<AuthDataResult?, Error> ) -> Void) {
        guard retryCount <= 4, error == nil else {
            completion(.failure(error!))
            Log.error(file: #file, function: #function, content: error!.localizedDescription)
            return}
        
        auth.user.sendEmailVerification {[weak self]  (error) in
            guard let self = self else { return}
            Log.info(file: #file, function: #function, items: ["Try to send Email Verification \(retryCount) times"])

            if error == nil {
                completion(.success(auth))
            } else {
                let retryCount = retryCount + 1
                self.sendEmailVerification(auth: auth, error: error, retryCount: retryCount, completion: completion)
            }
            
        }
    }

    func sendSignInLink(to email: String) {
      let actionCodeSettings = ActionCodeSettings()
        let stringURL = "https://\(K.authorizedDomain).firebaseapp.com/login?email=\(email)"
      actionCodeSettings.url = URL(string: stringURL)
      // The sign-in operation must be completed in the app.
      actionCodeSettings.handleCodeInApp = true
      actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)

      Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { error in
        guard error == nil else { return }
          
      }
    }
    
    //MARK: - Resend link methods
    func resendVerificationEmail(email: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().currentUser?.reload(completion: { (error) in
            
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                completion(error)
            })
        })
    }

    
    func resetPasswordFor(email: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            completion(error)
        }
    }
    
    func downloadUserFromFirebase(userID:String) {
        
    }
    
    func save(user: User) {
        guard let dict = user.dictionary else {
            Log.error(content: "Can't convert Encodable to Dictionary")
            return
        }
        do {
            try FirestoreCollection.User.reference.document(user.id).setData(dict)
            Log.success()
        } catch {
            Log.error(content: "Save user to Firebase unsuccessful!")
        }
    }
}

enum FirestoreCollection: String {
    case User
    case Recent
    case Messages
    case Typing
    case Channel
    
    var reference: CollectionReference {
        return Firestore.firestore().collection(self.rawValue)
    }
}


