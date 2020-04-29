//
//  OthersViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 28.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

final class OthersViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Прочее"
        
        navigationItem.backBarButtonItem = {
            let barButtonItem = UIBarButtonItem()
            barButtonItem.tintColor = .navBarTextColor
            return barButtonItem
        }()
        navigationController?.navigationBar.tintColor = .navBarTextColor
        navigationController?.navigationBar.titleTextAttributes = {
            [NSAttributedString.Key.foregroundColor: UIColor.navBarTextColor]
        }()
    }
    
    @IBAction func buttonDidTap(_ sender: UIButton) {
        let transitionHandler: TransitionHandler = self
        let module = Assembly.createModule(ContactsListModule.self, output: nil)
        transitionHandler.pushModule(module.view, animated: true)
    }
}
