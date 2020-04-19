//
//  RxAboutRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxSwift
import RxCocoa
import WebKit

protocol RxAboutRouterProtocol: class {
    var present: Binder<RxAboutRouter.State> { get }
    var push: Binder<RxAboutRouter.State> { get }
}

final class RxAboutRouter {
    weak var viewController: RxAboutViewController!
    weak var navigationController: UINavigationController!
}

extension RxAboutRouter: RxAboutRouterProtocol {
    enum State {
        case tips
        case web(WKWebView.Resource, String?)
    }
    
    var present: Binder<State> {
        viewController.rx.present
    }

    var push: Binder<State> {
        navigationController.rx.push
    }
}

fileprivate extension RxAboutRouter.State {
    var makeViewController: UIViewController? {
        switch self {
        case .tips:
            return nil /* TODO: create TipsViewController */
        case .web(let resource, let title):
            return WKWebViewController(with: resource, title: title)
        }
    }
}

private extension Reactive where Base : UIViewController {
    var present: Binder<RxAboutRouter.State> {
        Binder(base) { viewController, value in
            value.makeViewController.flatMap {
                viewController.present($0, animated: true)
            }
        }
    }
}

private extension Reactive where Base : UINavigationController {
    var push: Binder<RxAboutRouter.State> {
        Binder(base) { navigationController, value in
            value.makeViewController.flatMap {
                navigationController.pushViewController($0, animated: true)
            }
        }
    }
}

