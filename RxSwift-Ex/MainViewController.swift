//
//  MainViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

//fix

final class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendAboutViewController(at: &viewControllers)
    }
    
    private func appendAboutViewController(at viewControllers: inout [UIViewController]?) {
        Container.shared.resolve(RxAboutViewController.self).flatMap { vc in
            vc.tabBarItem = .init(tabBarSystemItem: .more, tag: 1)
            Container.shared.resolveNavigationController(module: .rxAbout).flatMap { nc in
                nc.setViewControllers([vc], animated: false)
                viewControllers?.append(nc)
            }
        }
        
        Container.shared.resolve(CombineAboutViewController.self).flatMap { vc in
            vc.tabBarItem = .init(tabBarSystemItem: .more, tag: 1)
            Container.shared.resolveNavigationController(module: .combineAbout).flatMap { nc in
                nc.setViewControllers([vc], animated: false)
                viewControllers?.append(nc)
            }
        }
    }
}
