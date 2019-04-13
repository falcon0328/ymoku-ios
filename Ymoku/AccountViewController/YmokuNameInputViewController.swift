//
//  YmokuNameInputViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit

class YmokuNameInputViewController: YmokuInputViewController {
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextSegue = "nextAffiliation"
    }
    
    override func canMoveToNextPage() -> Bool {
        // TODO: 正規表現してジャッジすること
        return true
    }
    
    override func configAccountData() -> Bool {
        guard let lastName = lastNameTextField.text, let firstName = firstNameTextField.text else {
            return false
        }
        ymokuAccount?.profile.lastName = lastName
        ymokuAccount?.profile.firstName = firstName
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

    }

}
