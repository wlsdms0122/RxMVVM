//
//  ColorListViewController.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ColorListViewController: BaseViewController<ColorListViewModel, ColorListViewCoordinator>, ViewControllable {
    // MARK: - View property
    
    // MARK: - Property
    
    // MARK: - Lifecycle
    override func loadView() {
        view = ColorListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Bind
    override func bind(_ viewModel: ColorListViewModel) {
        
    }
    
    // MARK: - Public
    
    // MARK: - Private

}
