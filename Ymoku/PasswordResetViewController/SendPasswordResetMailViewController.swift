//
//  SendPasswordResetMailViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/16.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit
import Infra

/// パスワードをリセットするメールを送る画面クラス
class SendPasswordResetMailViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTappedPasswordResetButton(_ sender: Any) {
        guard let email = mailTextField.text else {
            return
        }
        Authentication.sendPasswordReset(email: email, completion: { error in
            // TODO: エラー対処
            if let error = error {
                return
            }
            print("パスワードリセットメール送信")
        })
    }
    
    @IBAction func didTappedDoneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
