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
    public static func createUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password,
                               completion: { (authResult, error) in
                                completion(error)
        })
    }
}
