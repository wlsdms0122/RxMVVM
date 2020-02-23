//
//  ColorDetailViewCoordinator.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

class ColorDetailViewCoordinator: ViewCoordinator {
    // MARK: - Route
    enum Route {
        
    }
    
    // MARK: - Property
    unowned var viewController: UIViewController!
    var dismiss: ((UIViewController, Bool) -> Void)?
    
    // MARK: - Public
    @discardableResult
    func present(for route: Route, animated: Bool) -> UIViewController? {
        return nil
    }
    
    func get(for route: Route) -> (controller: UIViewController, coordinator: ViewCoordinatorType)? {
        return nil
    }
    
    deinit {
        Logger.verbose()
    }
}

