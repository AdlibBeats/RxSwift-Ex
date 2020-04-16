//
//  AboutViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 03/10/2019.
//  Copyright © 2019 ru.proarttherapy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit

protocol AboutViewProtocol: class {
    
}

final class AboutViewController: UIViewController, AboutViewProtocol {
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet weak var userAgreementButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    var presenter: AboutPresenterProtocol!
    let configurator: AboutConfiguratorProtocol = AboutConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
        
        func bind() {
            let output = presenter.transform(
                input: AboutPresenter.Input(
                    tipsTapEvent: tipsButton.rx.tap,
                    userAgreementTapEvent: userAgreementButton.rx.tap,
                    privacyPolicyTapEvent: privacyPolicyButton.rx.tap
                )
            )
            
            output.navBarTitle
                .drive(rx.title)
                .disposed(by: disposeBag)
            
            output.title
                .drive(titleLabel.rx.text)
                .disposed(by: disposeBag)
            
            output.description
                .drive(descriptionLabel.rx.text)
                .disposed(by: disposeBag)
            
            output.tipsTitle
                .drive(tipsButton.rx.title(for: .normal))
                .disposed(by: disposeBag)
            
            output.userAgreementTitle
                .drive(userAgreementButton.rx.title(for: .normal))
                .disposed(by: disposeBag)
            
            output.privacyPolicyTitle
                .drive(privacyPolicyButton.rx.title(for: .normal))
                .disposed(by: disposeBag)
            
            output.appVersion
                .drive(appVersionLabel.rx.text)
                .disposed(by: disposeBag)
        }
        
        bind()
    }
}
