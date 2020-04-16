//
//  AboutViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

protocol AboutViewControllerProtocol: class {
    func didSetNavBarTitle(_ newValue: String)
    func didSetTitle(_ newValue: String)
    func didSetDescription(_ newValue: String)
    func didSetTipsTitle(_ newValue: String)
    func didSetUserAgreementTitle(_ newValue: String)
    func didSetPrivacyPolicyTitle(_ newValue: String)
    func didSetAppVersion(_ newValue: String)
}

final class AboutViewController: UIViewController {
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet weak var userAgreementButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let configurator: AboutConfiguratorProtocol = AboutConfigurator()
    
    var presenter: AboutPresenterOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.didLoad()
        
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem().then {
            $0.tintColor = .init(red: 0.937, green: 0.565, blue: 0.729, alpha: 1)
        }
    }
    
    @IBAction func tipsDidTap(_ sender: UITapGestureRecognizer) {
        presenter.tipsDidTap()
    }
    
    @IBAction func privacyPolicyDidTap(_ sender: UITapGestureRecognizer) {
        presenter.privacyPolicyDidTap()
    }
    
    @IBAction func userAgreementDidTap(_ sender: UITapGestureRecognizer) {
        presenter.userAgreementDidTap()
    }
}

extension AboutViewController: AboutViewControllerProtocol {
    func didSetNavBarTitle(_ newValue: String) {
        title = newValue
    }
    
    func didSetTitle(_ newValue: String) {
        titleLabel.text = newValue
    }
    
    func didSetDescription(_ newValue: String) {
        descriptionLabel.text = newValue
    }
    
    func didSetTipsTitle(_ newValue: String) {
        tipsButton.setTitle(newValue, for: .normal)
    }
    
    func didSetUserAgreementTitle(_ newValue: String) {
        userAgreementButton.setTitle(newValue, for: .normal)
    }
    
    func didSetPrivacyPolicyTitle(_ newValue: String) {
        privacyPolicyButton.setTitle(newValue, for: .normal)
    }
    
    func didSetAppVersion(_ newValue: String) {
        appVersionLabel.text = newValue
    }
}
