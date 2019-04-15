//
//  Authentication.swift
//  Authentication
//
//  Created by aseo on 2019/04/09.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

/// 認証処理を行うクラス
public class Authentication {
    /// データベース
    private static let db = Firestore.firestore()
    /// プロフィールの各フィールド名
    private enum ProfileFieldName: String {
        /// タイムスタンプ
        case timestamp
        /// 表示名
        case displayName
        /// 姓
        case lastName
        /// 名
        case firstName
        /// 所属
        case affiliation
    }
    
    /// 現在ログインしているユーザ
    public static var currentLoginUser: AuthenticationUserData? {
        get {
            guard let user = AuthenticationUserData(user: Auth.auth().currentUser) else {
                return nil
            }
            return user
        }
    }
    
    /// 現在ログインしているかどうか
    public static var isLogin: Bool {
        if currentLoginUser == nil {
            return false
        }
        return true
    }
    
    /// ユーザを作成する機能を実装
    ///
    /// - Parameters:
    ///   - email: メールアドレス
    ///   - password: パスワード
    ///   - displayName: 表示名
    ///   - lastName: 姓
    ///   - firstName: 名前
    ///   - affiliation: 所属
    ///   - completion: 完了時のハンドラ
    public static func createUser(email: String,
                                  password: String,
                                  displayName: String,
                                  lastName: String,
                                  firstName: String,
                                  affiliation: String,
                                  completion: @escaping (Error?, AuthenticationUserData?) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password,
                               completion: { (authResult, error) in
                                guard let userData = AuthenticationUserData(user: authResult?.user) else {
                                    completion(error, nil)
                                    return
                                }
                                let profile = createProfile(displayName: displayName,
                                                            lastName: lastName,
                                                            firstName: firstName,
                                                            affiliation: affiliation)
                                db.collection("user").addDocument(data: profile, completion: { error in
                                    completion(error, userData)
                                })
        })
    }
    
    /// ログイン処理を行う
    ///
    /// - Parameters:
    ///   - email: メールアドレス
    ///   - password: パスワード
    ///   - completion: 完了時のハンドラ
    public static func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password,
                           completion: { (authResult, error) in
                            completion(error)
        })
    }
    
    /// プロフィール作成処理
    ///
    /// - Parameters:
    ///   - displayName: 表示名
    ///   - lastName: 姓
    ///   - firstName: 名
    ///   - affiliation: 所属
    /// - Returns: プロフィール情報の辞書
    static func createProfile(displayName: String, lastName: String, firstName: String, affiliation: String) -> [String: Any] {
        return [ProfileFieldName.timestamp.rawValue: FieldValue.serverTimestamp(),
                ProfileFieldName.displayName.rawValue: displayName,
                ProfileFieldName.lastName.rawValue: lastName,
                ProfileFieldName.firstName.rawValue: firstName,
                ProfileFieldName.affiliation.rawValue: affiliation]
    }
}
