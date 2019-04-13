//
//  YMokuInputViewController.swift
//  Ymoku
//
//  Created by aseo on 2019/04/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit
import Account

/// アカウント作成画面の基底クラス
///
/// - attention:
/// UITextViewやUILabelが1個、UITextFieldが任意の個数、UIButtonが2個の前提
class YmokuInputViewController: UIViewController {
    public var ymokuAccount: YmokuAccount?
    
    private var label: UILabel?
    private var textView: UITextView?
    private var textColor: UIColor?
    private var defaultText: String?
    /// 次の画面へのセグエ名
    ///
    /// - attention:
    /// 各サブクラスではこの名前をオーバーライドして利用すること
    public var nextSegue: String = ""
    
    var titleLabelText = "" {
        didSet {
            label?.text = titleLabelText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView(views: view.subviews)
        configRightBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        revertTextView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignFirstResponder(views: view.subviews)
    }
    
    /// エラーテキストをテキストビューに表示
    ///
    /// - Parameter text: エラーテキスト
    func showErrorTextView(text: String) {
        textColor = textView?.textColor
        defaultText = textView?.text
        textView?.textColor = UIColor.red
        textView?.text = text
    }
    
    /// テキストビューをデフォルトに戻す
    ///
    /// 戻る内容:
    /// - 文字色
    /// - 文字列
    func revertTextView() {
        textView?.textColor = textColor
        textView?.text = defaultText
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if !canMoveToNextPage() { return }
        if !configAccountData() { return }
        performSegue(withIdentifier: nextSegue, sender: self)
    }
    
    @objc func existAccountButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /// 次へボタンのセグエを実行できるかを判定する
    ///
    /// - Returns:
    public func canMoveToNextPage() -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let destination = segue.destination as? YmokuInputViewController else {
            return
        }
        destination.ymokuAccount = self.ymokuAccount
    }
    
    /// 入力されたデータをアカウントデータに反映する
    public func configAccountData() -> Bool {
        return true
    }
    
    /// 指定したviewのsubViewにある各viewに各種設定を行う
    ///
    /// 設定内容:
    /// - UITextFieldにはdelegateを指定
    /// - UITextViewやUILabelは変数として格納
    /// - UIButtonにはイベントを適用
    /// - Parameter view: UIView
    private func configView(views: [UIView]) {
        for view in views {
            if let textField = view as? UITextField {
                textField.delegate = self
            } else if let textView = view as? UITextView {
                textView.isEditable = false
                textView.isSelectable = false
                self.textView = textView
            } else if let label = view as? UILabel {
                self.label = label
            } else if let button = view as? UIButton {
                button.addTarget(self,
                                 action: #selector(existAccountButtonTapped(_:)),
                                 for: UIControl.Event.touchUpInside)
            } else {
                configView(views: view.subviews)
            }
        }
    }
    
    /// 右側のUIBarButtonを設定
    private func configRightBarButton() {
        let prev = self.navigationItem.rightBarButtonItem
        let next = UIBarButtonItem(title: prev?.title,
                                   style: .plain,
                                   target: self,
                                   action: #selector(nextButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = next
    }
    
    /// subViewも含めた入力状態の解除をする
    ///
    /// - Parameter views: UIViewの配列
    private func resignFirstResponder(views: [UIView]) {
        for view in views {
            if let textField = view as? UITextField {
                textField.resignFirstResponder()
            } else {
                resignFirstResponder(views: view.subviews)
            }
        }
    }
    
}

extension YmokuInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
