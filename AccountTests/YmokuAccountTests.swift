//
//  YmokuAccountTests.swift
//  AccountTests
//
//  Created by aseo on 2019/04/23.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import XCTest
@testable import Account

class YmokuAccountTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_正常系_コンストラクタ() {
        let uid = "userID"
        let email = "email"
        let password = "password"
        let displayName = "displayName"
        let lastName = "lastName"
        let firstName = "firstName"
        let affiliation = "affiliation"
        let profile = YmokuProfile(lastName: lastName, firstName: firstName, affiliation: affiliation)
        let account = YmokuAccount(userID: uid, email: email, password: password, displayName: displayName, profile: profile)
        XCTAssertEqual(account.userID, uid)
        XCTAssertEqual(account.email, email)
        XCTAssertEqual(account.password, password)
        XCTAssertEqual(account.displayName, displayName)
        XCTAssertEqual(profile.lastName, lastName)
        XCTAssertEqual(profile.firstName, firstName)
        XCTAssertEqual(profile.affiliation, affiliation)
    }

}
