//
//  AuthenticationUserData.swift
//  Infra
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import FirebaseAuth

/// 認証処理の結果返ってきたデータのレスポンスクラス
public struct AuthenticationUserData {
    /// ユーザID
    public let userID: String
    /// メールアドレス
    public let email: String
    
    /// イニシャライザ
    ///
    /// - Parameter user: Firebaseのユーザクラス
    public init?(user: User?) {
        guard let user = user, let email = user.email else {
            return nil
        }
        self.userID = user.uid
        self.email = email
    }
}
