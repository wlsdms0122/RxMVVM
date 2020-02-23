//
//  AppDelegate.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import JSInject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: AppCoordinator!
    
    // MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerDependencies()
        
        // Configure window & app coordinator
        let window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(window: window)
        
        // Present main view
        coordinator.present(for: .colorList, animated: true)
        
        self.window = window
        return true
    }
    
    // MARK: - Private
    private func registerDependencies() {
        // Register base services
        Container.shared.register(NetworkServiceProtocol.self, scope: .retain, container: "base") { NetworkService() }
        
        // Register application services
        Container.shared.register(ColorServiceProtocol.self) { ColorService() }
    }
}

