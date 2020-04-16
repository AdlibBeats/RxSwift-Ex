//
//  AboutRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxSwift
import RxCocoa
import WebKit

protocol AboutRouterProtocol: class {
    var present: Binder<AboutRouter.State> { get }
    var push: Binder<AboutRouter.State> { get }
}

final class AboutRouter: AboutRouterProtocol {
    private weak var viewController: AboutViewController!
    private weak var navigationController: UINavigationController!
    
    init(viewController: AboutViewController) {
        self.viewController = viewController
        
        guard let navigationController = viewController.navigationController else {
            fatalError("init(viewController:) has not been implemented")
        }
        self.navigationController = navigationController
    }
    
    var present: Binder<State> {
        viewController.rx.present
    }

    var push: Binder<State> {
        navigationController.rx.push
    }
}

extension AboutRouter {
    enum State {
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
    var present: Binder<AboutRouter.State> {
        Binder(base) { viewController, value in
            guard let source = value.makeViewController else { return }
            viewController.present(source, animated: true)
        }
    }
}

private extension Reactive where Base : UINavigationController {
    var push: Binder<AboutRouter.State> {
        Binder(base) { navigationController, value in
            guard let source = value.makeViewController else { return }
            navigationController.pushViewController(source, animated: true)
        }
    }
}

