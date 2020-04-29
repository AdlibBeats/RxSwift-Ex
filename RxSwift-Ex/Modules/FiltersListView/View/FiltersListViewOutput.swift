//
//  FiltersListViewOutput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol FiltersListViewOutput: class {
    var filtersList: Filters { get }
    
    func viewDidLoad()
    func tableViewDidSelect(_ index: Int)
}
