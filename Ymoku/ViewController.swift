//
//  ViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/09.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit
import Infra

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        Authentication.createUser(email: "falcon.x.0328@gmail.com", password: "******", completion: { e in
            print(user)
        })
    }
    
}

