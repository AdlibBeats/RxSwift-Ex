//
//  MainViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

final class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let aboutViewController = UINavigationController(
            rootViewController: RxAboutViewController()
        )
        
        aboutViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        viewControllers?.append(aboutViewController)
    }
}
