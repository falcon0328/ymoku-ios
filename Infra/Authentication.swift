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
        /// 姓
        case lastName
        /// 名
        case firstName
        /// 所属
        case affiliation
    }
    
    /// ユーザを作成する機能を実装
    ///
    /// - Parameters:
    ///   - email: メールアドレス
    ///   - password: パスワード
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
                                guard let user = authResult?.user, let email = user.email else {
                                    // TODO: エラー実装
                                    return
                                }
                                let userData = AuthenticationUserData.init(userID: user.uid,
                                                                           email: email,
                                                                           displayName: displayName)
                                let profile = createProfile(lastName: lastName,
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
    ///   - lastName: 姓
    ///   - firstName: 名
    ///   - affiliation: 所属
    /// - Returns: プロフィール情報の辞書
    static func createProfile(lastName: String, firstName: String, affiliation: String) -> [String: String] {
        return [ProfileFieldName.lastName.rawValue: lastName,
                ProfileFieldName.firstName.rawValue: firstName,
                ProfileFieldName.affiliation.rawValue: affiliation]
    }
}
