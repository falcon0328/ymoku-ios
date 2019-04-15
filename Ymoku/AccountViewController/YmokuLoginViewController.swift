//
//  YmokuLoginViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/15.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit
import Infra

/// ワイもく！のログインを行う画面
class YmokuLoginViewController: UIViewController {
    /// ログインボタン
    @IBOutlet weak var loginButton: UIButton!
    /// メールアドレスを入力するテキストフィールド
    @IBOutlet weak var emailTextField: UITextField!
    /// パスワードを入力するテキストフィールド
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTappedLoginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Authentication.login(email: email, password: password, completion: { error in
            if let error = error {
                // TODO: エラー対応
                return
            }
            print("Login Email: \(email)")
        })
    }
}
