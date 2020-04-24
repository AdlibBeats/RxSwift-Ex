//
//  CallViewController.swift
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

import VoxImplantSDK
import CallKit

final class CallViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contactUsernameLabel: UITextField!
    @IBOutlet private weak var callButton: UIButton!
    
    var client: VIClient?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.kbrMainPink]
        
        callButton.layer.cornerRadius = callButton.frame.height / 2
        
        func bind() {
            callButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    guard
                        let self = self,
                        let client = self.client,
                        client.clientState == .loggedIn,
                        let contactUsername = self.contactUsernameLabel.text else { return }
                    
                    let callSettings = VICallSettings()
                    callSettings.videoFlags = VIVideoFlags.videoFlags(receiveVideo: true, sendVideo: true)

                    if let call = client.call("\(contactUsername).voximpant.com", settings: callSettings) {
                        call.start()
                    }
                })
                .disposed(by: disposeBag)
        }
        
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        client?.disconnect()
        
        navigationController?.navigationItem.title = "Login"
    }
}
