//
//  YmokuAccount.swift
//  Account
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// ワイもく！のアカウントを表現するクラス
public struct YmokuAccount {
    /// ユーザID
    public var userID: String
    /// メールアドレス
    public var email: String
    /// パスワード
    public var password: String
    /// 表示名
    public var displayName: String
    /// プロフィール
    public var profile: YmokuProfile
    
    /// イニシャライザ
    ///
    /// - Parameters:
    ///   - userID: ユーザID
    ///   - email: メールアドレス
    ///   - password: パスワード
    ///   - displayName: 表示名
    ///   - profile: プロフィール
    public init(userID: String,
                email: String,
                password: String,
                displayName: String,
                profile: YmokuProfile) {
        self.userID = userID
        self.email = email
        self.password = password
        self.displayName = displayName
        self.profile = profile
    }
}
