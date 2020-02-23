//
//  ColorListCellViewModel.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import RxSwift
import RxCocoa

class ColorListCellViewModel: BaseViewModel {
    // MARK: - Input
    struct Input {
        
    }
    
    // MARK: - Output
    var name: Driver<String> { _name.asDriver() }
    var hex: Driver<String> { _hex.asDriver() }
    var isFavorite: Driver<Bool> { _isFavorite.asDriver() }
    
    // MARK: - State
    private let _name: BehaviorRelay<String>
    private let _hex: BehaviorRelay<String>
    private let _isFavorite: BehaviorRelay<Bool>
    
    // MARK: - Property
    var input: Input = Input()
    
    let color: Color
    
    // MARK: - Constructor
    init(color: Color) {
        self.color = color
        
        _name = BehaviorRelay(value: color.name)
        _hex = BehaviorRelay(value: color.hex)
        _isFavorite = BehaviorRelay(value: color.isFavorite)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    deinit {
        Logger.verbose()
    }
}
