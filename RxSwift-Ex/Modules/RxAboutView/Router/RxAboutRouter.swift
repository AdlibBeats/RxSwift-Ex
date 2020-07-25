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
import Swinject

protocol RxAboutRouterProtocol: class {
    var present: Binder<RxAboutRouter.State> { get }
    var push: Binder<RxAboutRouter.State> { get }
}

final class RxAboutRouter { }

extension RxAboutRouter: RxAboutRouterProtocol {
    enum State {
        case tips
        case web(WKWebView.Resource, String?)
    }
    
    var present: Binder<State> {
        Binder(self) { _, state in
            Container.shared.resolve(RxAboutViewController.self).flatMap { nc in
                makeViewController(with: state).flatMap { vc in
                    nc.present(vc, animated: true)
                }
            }
        }
        
    }
    
    var push: Binder<State> {
        Binder(self) { _, state in
            Container.shared.resolveNavigationController(module: .rxAbout).flatMap { nc in
                makeViewController(with: state).flatMap { vc in
                    nc.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

private func makeViewController(with state: RxAboutRouter.State) -> UIViewController? {
    switch state {
    case .tips:
        return nil /* TODO: create TipsViewController */
    case .web(let resource, let title):
        return WKWebViewController(with: resource, title: title)
    }
}
