//
//  Authentication.swift
//  Authentication
//
//  Created by aseo on 2019/04/09.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import FirebaseAuth

public class Authentication {
    /// ユーザを作成する機能を実装
    ///
    /// - Parameters:
    ///   - email: メールアドレス
    ///   - password: パスワード
    ///   - completion: 完了時のハンドラ
    public static func createUser(email: String, password: String, completion: @escaping (Error?, AuthenticationUserData?) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password,
                               completion: { (authResult, error) in
                                guard let user = authResult?.user, let email = user.email, let displayName = user.displayName else {
                                    // TODO: エラー実装
                                    return
                                }
                                let userData = AuthenticationUserData.init(userID: user.uid,
                                                                           email: email,
                                                                           displayName: displayName)
                                completion(error, userData)
        })
    }
}
