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
        case userID
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
                                  completion: @escaping (NSError?, AuthenticationUserData?) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password,
                               completion: { (authResult, error) in
                                if error != nil {
                                    completion(NSError(domain: YmokuErrorDomain, code: AccountCreateFailed, userInfo: nil), nil)
                                    return
                                }
                                let chengeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                chengeRequest?.displayName = displayName
                                chengeRequest?.commitChanges(completion: { (error) in
                                    if error != nil {
                                        completion(NSError(domain: YmokuErrorDomain, code: DisplaynameChangeFailed, userInfo: nil), nil)
                                        return
                                    }
                                    guard let userData = AuthenticationUserData(user: authResult?.user) else {
                                        completion(NSError(domain: YmokuErrorDomain, code: InvalidUserData, userInfo: nil), nil)
                                        return
                                    }
                                    let profile = createProfile(userID: userData.userID,
                                                                lastName: lastName,
                                                                firstName: firstName,
                                                                affiliation: affiliation)
                                    db.collection("user").addDocument(data: profile, completion: { error in
                                        if error != nil {
                                            completion(NSError(domain: YmokuErrorDomain, code: SaveUserDataFailed, userInfo: nil), nil)
                                        }
                                        completion(nil, userData)
                                    })
                                })
        })
    }
    
    /// ログイン処理を行う
    ///
    /// - Parameters:
    ///   - email: メールアドレス
    ///   - password: パスワード
    ///   - completion: 完了時のハンドラ
    public static func login(email: String, password: String, completion: @escaping (NSError?) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password,
                           completion: { (authResult, error) in
                            completion(NSError(domain: YmokuErrorDomain, code: LoginFailed, userInfo: nil))
        })
    }
    
    /// ログアウト処理を行う
    ///
    /// - Throws: ログアウト失敗時のエラー
    public static func logout() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw NSError(domain: YmokuErrorDomain, code: LogoutFailed, userInfo: nil)
        }
    }
    
    /// パスワードをリセットするメールを送信する
    ///
    /// - Parameters:
    ///   - email: メールアドレス
    ///   - completion: 完了時のハンドラ
    public static func sendPasswordReset(email: String, completion: @escaping(NSError?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { error in
            if error != nil {
                completion(NSError(domain: YmokuErrorDomain, code: SendPasswordResetMailFailed, userInfo: nil))
                return
            }
            completion(nil)
        })
    }
    
    /// プロフィール作成処理
    ///
    /// - Parameters:
    ///   - userID: ユーザID
    ///   - lastName: 姓
    ///   - firstName: 名
    ///   - affiliation: 所属
    /// - Returns: プロフィール情報の辞書
    static func createProfile(userID: String, lastName: String, firstName: String, affiliation: String) -> [String: Any] {
        return [ProfileFieldName.timestamp.rawValue: FieldValue.serverTimestamp(),
                ProfileFieldName.userID.rawValue: userID,
                ProfileFieldName.lastName.rawValue: lastName,
                ProfileFieldName.firstName.rawValue: firstName,
                ProfileFieldName.affiliation.rawValue: affiliation]
    }
}
