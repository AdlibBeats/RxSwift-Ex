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

final class AboutViewController: UIViewController {
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet weak var userAgreementButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = AboutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        guard let navigationController = self.navigationController else { return }
        
        func bind() {
            let output = viewModel.transform(
                input: AboutViewModel.Input(
                    tipsTapEvent: tipsButton.rx.tap,
                    userAgreementTapEvent: userAgreementButton.rx.tap,
                    privacyPolicyTapEvent: privacyPolicyButton.rx.tap
                )
            )
            
            output.present
                .map({ $0.makeViewController })
                .drive(rx.present)
                .disposed(by: disposeBag)
            
            output.push
                .map({ $0.makeViewController })
                .drive(navigationController.rx.push)
                .disposed(by: disposeBag)
        }
        
        bind()
    }
}

extension AboutViewController {
    enum Router {
        case tips
        case web(WKWebView.Resource, String?)
        case none
        
        var makeViewController: UIViewController? {
            switch self {
            case .tips:
                return nil /* TODO: create TipsViewController */
            case .web(let resource, let title):
                return WKWebViewController(with: resource, title: title)
            default: return nil
            }
        }
    }
}

private extension Reactive where Base : UIViewController {
    var present: Binder<UIViewController?> {
        Binder(base) { viewController, value in
            guard let source = value else { return }
            viewController.present(source, animated: true)
        }
    }
}

private extension Reactive where Base : UINavigationController {
    var push: Binder<UIViewController?> {
        Binder(base) { navigationController, value in
            guard let source = value else { return }
            navigationController.pushViewController(source, animated: true)
        }
    }
}
