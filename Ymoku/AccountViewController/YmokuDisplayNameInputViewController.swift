//
//  YmokuDisplayNameInputViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit

class YmokuDisplayNameInputViewController: YmokuInputViewController {
    @IBOutlet weak var displayNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextSegue = "nextNameSegue"
    }
    
    override func canMoveToNextPage() -> Bool {
        // TODO: 正規表現してジャッジすること
        return true
    }
    
    override func configAccountData() -> Bool {
        guard let displayName = displayNameTextField.text else {
            return false
        }
        ymokuAccount?.displayName = displayName
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
    }
}
