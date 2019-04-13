//
//  YmokuAccountCreateViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit
import Account

class YmokuAccountCreateViewController: YmokuInputViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextSegue = "nextDisplayNameSegue"
        ymokuAccount = YmokuAccount(userID: "",
                                    email: "",
                                    password: "",
                                    displayName: "",
                                    profile: YmokuProfile(lastName: "", firstName: "", affiliation: ""))
    }
    
    override func canMoveToNextPage() -> Bool {
        // TODO: 正規表現してジャッジすること
        return true
    }
    
    override func configAccountData() -> Bool {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return false
        }
        ymokuAccount?.email = email
        ymokuAccount?.password = password
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

    }
}
