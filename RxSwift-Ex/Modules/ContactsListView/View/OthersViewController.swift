//
//  OthersViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 28.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

class OthersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Прочее"
        
        navigationItem.backBarButtonItem = {
            let barButtonItem = UIBarButtonItem()
            barButtonItem.tintColor = UIColor(red: 0.306, green: 0.380, blue: 0.451, alpha: 1)
            return barButtonItem
        }()
        navigationController?.navigationBar.tintColor = UIColor(red: 0.306, green: 0.380, blue: 0.451, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = {
            [NSAttributedString.Key.foregroundColor: UIColor(red: 0.306, green: 0.380, blue: 0.451, alpha: 1)]
        }()
    }
}
