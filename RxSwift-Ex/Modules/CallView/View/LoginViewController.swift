//
//  LoginViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 22.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import SVProgressHUD

import RxSwift
import RxCocoa
import RxBinding

import Swinject
import SwinjectStoryboard

import VoxImplantSDK
import PushKit

final class LoginViewController: UIViewController {
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    
    var client: VIClient?
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Login"
    }
    
    private let isLoginButtonEnabled = BehaviorRelay<Bool>(value: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = VIClient(delegateQueue: DispatchQueue.main)
        client?.sessionDelegate = self
        
        passwordTextField.enablesReturnKeyAutomatically = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.kbrMainPinkColor]
        
        func bind() {
            Observable
                .merge(
                    loginTextField.rx.controlEvent(.editingChanged).map { _ in },
                    passwordTextField.rx.controlEvent(.editingChanged).map { _ in })
                .withLatestFrom(
                    Observable
                        .combineLatest(
                            loginTextField.rx.text.compactMap { $0?.isEmpty }.map { !$0 },
                            passwordTextField.rx.text.compactMap { $0?.isEmpty }.map { !$0 })
                        .map { $0 && $1 }) ~> isLoginButtonEnabled ~
                isLoginButtonEnabled ~> loginButton.rx.isEnabled ~
                loginTextField.rx.controlEvent(.editingDidEndOnExit) ~>
                passwordTextField.rx.becomeFirstResponder ~
                passwordTextField.rx.controlEvent(.editingDidEndOnExit) ~>
                passwordTextField.rx.resignFirstResponder ~
                view.rx.tapGesture().when(.recognized).map { _ in true } ~>
                view.rx.endEditing ~
                isLoginButtonEnabled.map { $0 ?
                    UIColor.kbrMainPinkColor :
                    UIColor.kbrMainPinkColor.withAlphaComponent(0.2)
                } ~> loginButton.rx.textColor(for: .normal) ~
                Observable
                    .merge(
                        passwordTextField.rx.controlEvent(.editingDidEndOnExit).map { _ in },
                        loginButton.rx.tap.map { _ in })
                    .subscribe(onNext: { [weak self] in
                        self?.client?.connect()
                        self?.updateUI(with: true)
                    }) ~ disposeBag
        }
        bind()
    }
    
    private func updateUI(with loading: Bool) {
        self.rx.executeProgress.on(.next(loading))
        self.loginTextField.rx.isEnabled.on(.next(!loading))
        self.passwordTextField.rx.isEnabled.on(.next(!loading))
        isLoginButtonEnabled.accept(!loading)
    }
    
    func login() {
        guard
            let client = self.client,
            let login = self.loginTextField.text,
            let password = self.passwordTextField.text else {
                updateUI(with: false)
                return
        }
        
        client.login(
            withUser: "\(login).voximplant.com",
            password: password,
            success: { [weak self] displayName, authParams in
                self?.updateUI(with: false)
                
                (SwinjectStoryboard
                    .create(name: "CallView", bundle: nil)
                    .instantiateViewController(withIdentifier: "CallViewController") as? CallViewController).flatMap {
                        $0.title = displayName
                        $0.client = client
                        $0.loginAction = { [weak self] in self?.login() }
                        
                        self?.title = "Logout"
                        self?.rx.push.on(.next($0))
                }
            },
            failure: { [weak self] error in
                self?.updateUI(with: false)
                
                print("Login failed")
            }
        )
    }
}

extension LoginViewController: VIClientSessionDelegate {
    func clientSessionDidConnect(_ client: VIClient) {
        login()
    }
    
    func clientSessionDidDisconnect(_ client: VIClient) {
        updateUI(with: false)
        
        print("Client did disconnect")
    }
    
    func client(_ client: VIClient, sessionDidFailConnectWithError error: Error) {
        updateUI(with: false)
        
        print("Client did fail connect")
    }
}
