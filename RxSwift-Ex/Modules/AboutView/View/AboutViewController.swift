//
//  AboutViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController {
    @IBOutlet private weak var tipsButton: UIButton!
    @IBOutlet private weak var userAgreementButton: UIButton!
    @IBOutlet private weak var privacyPolicyButton: UIButton!
    @IBOutlet private weak var appVersionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private let configurator: AboutConfiguratorProtocol = AboutConfigurator()
    
    var output: AboutViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        output.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem().then {
            $0.tintColor = .kbrMainPinkColor
        }
    }
    
    @IBAction func tipsDidTap(_ sender: UITapGestureRecognizer) {
        output.tipsDidTap()
    }
    
    @IBAction func privacyPolicyDidTap(_ sender: UITapGestureRecognizer) {
        output.privacyPolicyDidTap()
    }
    
    @IBAction func userAgreementDidTap(_ sender: UITapGestureRecognizer) {
        output.userAgreementDidTap()
    }
}

// MARK: AboutViewInput
extension AboutViewController: AboutViewInput {
    func setNavBarTitle(_ newValue: String) {
        title = newValue
    }
    
    func setTitle(_ newValue: String) {
        titleLabel.text = newValue
    }
    
    func setDescription(_ newValue: String) {
        descriptionLabel.text = newValue
    }
    
    func setTipsTitle(_ newValue: String) {
        tipsButton.setTitle(newValue, for: .normal)
    }
    
    func setUserAgreementTitle(_ newValue: String) {
        userAgreementButton.setTitle(newValue, for: .normal)
    }
    
    func setPrivacyPolicyTitle(_ newValue: String) {
        privacyPolicyButton.setTitle(newValue, for: .normal)
    }
    
    func setAppVersion(_ newValue: String) {
        appVersionLabel.text = newValue
    }
}
