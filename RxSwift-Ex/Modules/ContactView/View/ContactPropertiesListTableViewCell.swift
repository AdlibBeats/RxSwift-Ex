//
//  ContactPropertiesListTableViewCell.swift
//  RxSwift-Ex
//
//  Created by Andrew on 28.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

final class ContactPropertiesListTableViewCell: UITableViewCell {
    var property: ContactProperty! {
        willSet {
            titleLabel.text = newValue?.title ?? ""
            valueLabel.text = newValue?.value ?? ""
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UITextView! {
        willSet {
            newValue?.linkTextAttributes = [
                .foregroundColor: UIColor(red: 1.0, green: 0.6, blue: 0, alpha: 1),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        }
    }
    
    
}
