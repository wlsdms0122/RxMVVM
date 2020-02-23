//
//  ColorDetailViewBuilder.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

class ColorDetailViewBuilder: Builder {
    // MARK: - Dependency
    struct Dependency {
        let color: Color
    }
    
    // MARK: - Property
    var dependency: Dependency
    
    // MARK: - Constructor
    required init(with dependency: Dependency) {
        self.dependency = dependency
    }
    
    // MARK: - Public
    func build() -> (UIViewController, ViewCoordinatorType)? {
        let coordinator = ColorDetailViewCoordinator()
        let viewModel = ColorDetailViewModel(color: dependency.color)
        let viewController = ColorDetailViewController(viewModel: viewModel, coordinator: coordinator)
        
        // DI
        coordinator.viewController = viewController
        
        return (viewController, coordinator)
    }
}
