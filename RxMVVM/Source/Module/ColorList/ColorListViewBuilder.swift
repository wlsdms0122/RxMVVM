//
//  ColorListViewBuilder.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

class ColorListViewBuilder: Builder {
    // MARK: - Dependency
    struct Dependency {
        
    }
    
    // MARK: - Property
    var dependency: Dependency
    
    // MARK: - Constructor
    required init(with dependency: Dependency) {
        self.dependency = dependency
    }
    
    // MARK: - Public
    func build() -> (UIViewController, ViewCoordinatorType)? {
        let coordinator = ColorListViewCoordinator()
        let viewModel = ColorListViewModel()
        let viewController = ColorListViewController(viewModel: viewModel, coordinator: coordinator)
        
        // DI
        coordinator.viewController = viewController
        
        return (viewController, coordinator)
    }
}
