//
//  YmokuError.swift
//  Infra
//
//  Created by aseo on 2019/04/16.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// ワイもく！アプリのエラードメイン
public let YmokuErrorDomain = "jp.co.falcon-tech.Ymoku"

/// アカウント作成失敗
public let AccountCreateFailed = 10100
/// 表示名変更失敗
public let DisplaynameChangeFailed = 10101
/// 不正なユーザデータ
public let InvalidUserData = 10102
/// ユーザの情報を保存できなかった
public let SaveUserDataFailed = 10103
/// ログイン失敗
public let LoginFailed = 10104
/// ログアウト失敗
public let LogoutFailed = 10105
/// パスワードリセットのメール送信に失敗する
public let SendPasswordResetMailFailed = 10106

