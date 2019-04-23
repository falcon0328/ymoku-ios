//
//  YmokuProfileTests.swift
//  AccountTests
//
//  Created by aseo on 2019/04/17.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import XCTest
@testable import Account

class YmokuProfileTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_正常系_profileのイニシャライザ() {
        let lastName = "lastName"
        let firstName = "firstName"
        let affiliation = "affiliation"
        let p = YmokuProfile(lastName: lastName,
                             firstName: firstName,
                             affiliation: affiliation)
        XCTAssertEqual(p.lastName, lastName)
        XCTAssertEqual(p.firstName, firstName)
        XCTAssertEqual(p.affiliation, affiliation)
    }

}
