//
//  Router.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

protocol Router {
    var navigation: UINavigationController? { get }
}

extension Router {
    func openScene(controller: UIViewController) {
        navigation?.pushViewController(controller, animated: true)
    }
}

protocol TransitionHandler: AnyObject {
    func pushModule(_ controller: UIViewController, animated: Bool)
    func presentModule(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func closeCurrentModule(_ animated: Bool)
    func showModuleInCurrentView(_ controller: UIViewController)
}

extension UIViewController: TransitionHandler {
    func pushModule(_ controller: UIViewController, animated: Bool) {
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func presentModule(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        present(controller, animated: animated, completion: completion)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }

    func closeCurrentModule(_ animated: Bool) {
        if let parent = parent as? UINavigationController, parent.children.count > 1 {
            parent.popViewController(animated: animated)
        } else if let _ = presentingViewController {
            dismiss(animated: animated, completion: nil)
        } else {
            removeFromParent()
            view.removeFromSuperview()
        }
    }

    func showModuleInCurrentView(_ controller: UIViewController) {
        guard let self = self as? ShowModuleInCurrentModuleProtocol else {
            presentModule(controller, animated: true, completion: nil)
            return
        }

        self.showModuleOnView(controller)
    }
}


protocol ShowModuleInCurrentModuleProtocol {
    func showModuleOnView(_ controller: UIViewController)
}
