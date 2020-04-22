//
//  LoginViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 22.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBinding
import Swinject
import SwinjectStoryboard

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.kbrMainPink]
        
        func bind() {
            let isLoginButtonEnabled = BehaviorRelay<Bool>(value: true)
            Observable.combineLatest(
                loginTextField.rx.text.compactMap { $0?.isEmpty }.map { !$0 },
                passwordTextField.rx.text.compactMap { $0?.isEmpty }.map { !$0 }
            ).map { $0 && $1 } ~> isLoginButtonEnabled ~
                isLoginButtonEnabled ~> loginButton.rx.isEnabled ~
                loginTextField.rx.controlEvent(.editingDidEndOnExit) ~>
                passwordTextField.rx.becomeFirstResponder ~
                passwordTextField.rx.controlEvent(.editingDidEndOnExit) ~>
                passwordTextField.rx.resignFirstResponder ~
                view.rx.tapGesture().when(.recognized).map { _ in true } ~>
                view.rx.endEditing ~ disposeBag
            loginButton.titleLabel.flatMap { isLoginButtonEnabled.map { $0 ?
                    UIColor.kbrMainPink :
                    UIColor.kbrMainPink.withAlphaComponent(0.2)
                } ~> $0.rx.textColor ~ disposeBag
            }
            navigationController.flatMap {
                let viewControllerMapper = {
                    SwinjectStoryboard
                        .create(name: "CallView", bundle: nil)
                        .instantiateViewController(withIdentifier: "CallViewController")
                }
                passwordTextField.rx.controlEvent(.editingDidEndOnExit).map(viewControllerMapper) ~> $0.rx.push ~
                loginButton.rx.tap.map(viewControllerMapper) ~> $0.rx.push ~ disposeBag
            }
        }
        
        bind()
    }
}
