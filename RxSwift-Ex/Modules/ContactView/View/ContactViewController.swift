//
//  ContactViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    
    var output: ContactViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewDidLoad()
    }
}

extension ContactViewController: ContactViewInput {
    func setNavBarTitle(_ newValue: String) {
        title = newValue
    }
    
    func setName(_ newValue: String) {
        nameLabel.text = newValue
    }
    
    func setPhone(_ newValue: String) {
        phoneLabel.text = newValue
    }
}
