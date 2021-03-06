//
//  FiltersListTableViewCell.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

final class FiltersListTableViewCell: UITableViewCell {
    var filter: Filter! {
        willSet {
            titleLabel.text = newValue?.title
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
}
