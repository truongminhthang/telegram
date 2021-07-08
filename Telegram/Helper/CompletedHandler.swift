//
//  CompletedHandler.swift
//  Telegram
//
//  Created by Thang Truong on 30/06/2021.
//

import Foundation

func completedHanlder<T, Q>(_ returnData: T, _ error: Error?, transform: (T) -> Q, completion: @escaping (_ result: Result<Q, Error>) -> Void) {
    guard error == nil else {
        completion(.failure(error!))
        return
    }
    completion(.success(transform(returnData)))
}

func completedHanlder<T>(_ returnData: T, _ error: Error?, completion: @escaping (_ result: Result<T, Error>) -> Void) {
    guard error == nil else {
        completion(.failure(error!))
        Log.error(items: ["Save user to Firebase unsuccessful!"])
        return
    }
    completion(.success(returnData))

}
