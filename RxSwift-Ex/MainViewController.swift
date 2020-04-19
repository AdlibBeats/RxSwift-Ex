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
        guard let viewController = Container.shared.resolve(
            UINavigationController.self,
            name: "RxAboutNavigationView"
        ) else { return }
        
        viewController.tabBarItem = .init(tabBarSystemItem: .more, tag: 1)
        viewControllers?.append(viewController)
    }
}
