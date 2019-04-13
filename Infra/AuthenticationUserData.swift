//
//  AuthenticationUserData.swift
//  Infra
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// 認証処理の結果返ってきたデータのレスポンスクラス
public struct AuthenticationUserData {
    /// ユーザID
    public let userID: String
    /// メールアドレス
    public let email: String
    /// 表示名
    public let displayName: String
}
