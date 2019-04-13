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
    public let userID: String
    /// メールアドレス
    public let email: String
    /// 表示名
    public let displayName: String
    /// プロフィール
    public let profile: YmokuProfile
}
