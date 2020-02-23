//
//  BaseViewController.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import RxSwift

class BaseViewController<ViewModel: BaseViewModel, Coordinator: ViewCoordinator>: UIViewController {
    let coordinator: Coordinator
    let viewModel: ViewModel
    
    private(set) var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Constructor
    init(viewModel: ViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        bind(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    func bind(_ viewModel: ViewModel) {
        // Binding
    }
}
