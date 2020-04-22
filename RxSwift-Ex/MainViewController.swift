//
//  MainViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import Swinject

final class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendAboutViewController()
    }
    
    private func appendAboutViewController() {
        Container.shared.resolve(RxAboutViewController.self).flatMap { vc in
            vc.tabBarItem = .init(tabBarSystemItem: .more, tag: 1)
            Container.shared.resolve(UINavigationController.self, name: "RxAboutNavigationView").flatMap { [weak self] nc in
                nc.setViewControllers([vc], animated: false)
                self?.viewControllers?.append(nc)
            }
        }
    }
}
