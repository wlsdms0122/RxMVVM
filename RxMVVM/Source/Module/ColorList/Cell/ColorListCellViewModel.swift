//
//  ColorListCellViewModel.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import RxSwift

class ColorListCellViewModel: BaseViewModel, ViewModel {
    // MARK: - Input
    struct Input {
        
    }
    let input: Input = Input()
    
    // MARK: - Output
    struct Output {
        let name: Observable<String>
        let hex: Observable<String>
        let isFavorite: Observable<Bool>
    }
    let output: Output
    
    // MARK: - State
    
    // MARK: - Property
    let color: Color
    
    // MARK: - Constructor
    init(color: Color) {
        self.color = color
        
        let name = BehaviorSubject<String>(value: color.name)
        let hex = BehaviorSubject<String>(value: color.hex)
        let isFavorite = BehaviorSubject<Bool>(value: color.isFavorite)
        
        output = Output(
            name: name,
            hex: hex,
            isFavorite: isFavorite
        )
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    deinit {
        Logger.verbose()
    }
}
