//
//  YmokuAffiliationViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit

class YmokuAffiliationViewController: YmokuInputViewController {

    @IBOutlet weak var affiliationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func canMoveToNextPage() -> Bool {
        // TODO: 正規表現してジャッジすること
        return true
    }
    
    override func configAccountData() -> Bool {
        guard let affiliation = affiliationTextField.text else {
            return false
        }
        ymokuAccount?.profile.affiliation = affiliation
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
}
