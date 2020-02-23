//
//  ColorListViewCoordinator.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

class ColorListViewCoordinator: ViewCoordinator {
    // MARK: - Route
    enum Route {
        case detail(color: Color)
    }
    
    // MARK: - Property
    unowned var viewController: UIViewController!
    var dismiss: ((UIViewController, Bool) -> Void)?
    
    // MARK: - Public
    @discardableResult
    func present(for route: Route, animated: Bool) -> UIViewController? {
        guard case (let controller, var coordinator)? = get(for: route) else { return nil }
        let presentingViewController = controller
        
        switch route {
        case .detail:
            // Set dismiss handler
            coordinator.dismiss = popViewController
            viewController.navigationController?.pushViewController(presentingViewController, animated: true)
        }
        
        return controller
    }
    
    func get(for route: Route) -> (controller: UIViewController, coordinator: ViewCoordinatorType)? {
        switch route {
        case let .detail(color: color):
            let dependency = ColorDetailViewBuilder.Dependency(color: color)
            return ColorDetailViewBuilder(with: dependency).build()
        }
    }
    
    deinit {
        Logger.verbose()
    }
}
