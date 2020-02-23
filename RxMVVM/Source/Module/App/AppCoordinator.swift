//
//  AppCoordinator.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

class AppCoordinator: LaunchCoordinator {
    // MARK: - Route
    enum Route {
        case colorList
    }
    
    // MARK: - Property
    var window: UIWindow
    
    // MARK: - Constructor
    init(window: UIWindow) {
        self.window = window
    }
    
    @discardableResult
    func present(for route: Route, animated: Bool) -> UIViewController? {
        guard let (controller, _) = get(for: route) else { return nil }
        var presentingViewController = controller
        
        switch route {
        case .colorList:
            // Wrap view to naviagtion container
            presentingViewController = UINavigationController(rootViewController: presentingViewController)
            // Present intro view
            window.rootViewController = presentingViewController
            window.makeKeyAndVisible()
        }
        
        return controller
    }
    
    func get(for route: Route) -> (controller: UIViewController, coordinator: ViewCoordinatorType)? {
        switch route {
        case .colorList:
            let dependency = ColorListViewBuilder.Dependency()
            return ColorListViewBuilder(with: dependency).build()
        }
    }
    
    deinit {
        Logger.verbose()
    }
}
