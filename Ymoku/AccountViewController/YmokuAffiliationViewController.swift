//
//  YmokuAffiliationViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/13.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit
import Infra

class YmokuAffiliationViewController: YmokuInputViewController {

    @IBOutlet weak var affiliationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self,
                                                                 action: #selector(doneButtonTapped(_:)))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        configAffiliationIfNeed()
        createYmokuUser()
    }
    
    /// 所属のパラメータを設定する
    func configAffiliationIfNeed() {
        guard let affiliation = affiliationTextField.text else {
            return
        }
        ymokuAccount?.profile.affiliation = affiliation
    }
    
    /// ワイもく！アカウントの作成処理を呼び出すメソッド
    func createYmokuUser() {
        guard let ymokuAccount = ymokuAccount else {
            return
        }
        Authentication.createUser(email: ymokuAccount.email,
                                  password: ymokuAccount.password,
                                  displayName: ymokuAccount.displayName,
                                  lastName: ymokuAccount.profile.lastName,
                                  firstName: ymokuAccount.profile.firstName,
                                  affiliation: ymokuAccount.profile.affiliation,
                                  completion: { error, userData in
                                    if let error = error {
                                        //TODO: エラー処理
                                        return
                                    }
                                    guard let userData = userData else {
                                        //TODO: エラー処理
                                        return
                                    }
                                    print(userData)
                                    
        })
    }
}
