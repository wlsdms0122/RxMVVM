//
//  ColorDetailViewModel.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import RxSwift

class ColorDetailViewModel: BaseViewModel, ViewModel {
    // MARK: - Input
    struct Input {
        
    }
    let input: Input = Input()
    
    // MARK: - Output
    struct Output {
        let name: Observable<String>
        let hex: Observable<String>
    }
    let output: Output
    
    // MARK: - State
    
    // MARK: - Property
    
    // MARK: - Constructor
    init(color: Color) {
        let name = BehaviorSubject(value: color.name)
        let hex = BehaviorSubject(value: color.hex)
        
        output = Output(
            name: name,
            hex: hex
        )
        super.init()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    deinit {
        Logger.verbose()
    }
}
