//
//  YmokuProfile.swift
//  Account
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// ワイもく！のプロフィール情報
public struct YmokuProfile {
    /// 名字
    public var lastName: String
    /// 名前
    public var firstName: String
    /// 所属
    public var affiliation: String
    
    /// イニシャライザ
    ///
    /// - Parameters:
    ///   - lastName: 名字
    ///   - firstName: 名前
    ///   - affiliation: 所属
    public init(lastName: String, firstName: String, affiliation: String) {
        self.lastName = lastName
        self.firstName = firstName
        self.affiliation = affiliation
    }
}
