//
//  ColorDetailViewController.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ColorDetailViewController: BaseViewController<ColorDetailViewModel, ColorDetailViewCoordinator>, ViewControllable {
    // MARK: - View property
    
    // MARK: - Property
    
    // MARK: - Lifecycle
    override func loadView() {
        view = ColorDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Bind
    
    // MARK: - Public
    
    // MARK: - Private

}
