//
//  ColorService.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import RxSwift
import JSInject

protocol ColorServiceProtocol {
    func fetchColors(with isFavorite: Bool) -> Single<[Color]>
}

class ColorService: ColorServiceProtocol {
    @Inject(container: "base")
    private var networkService: NetworkServiceProtocol
    
    func fetchColors(with isFavorite: Bool = false) -> Single<[Color]> {
        let colors = networkService.fetchColors()
            .map { $0.shuffled() }
        
        if isFavorite {
            return colors.map { $0.filter { $0.isFavorite } }
        } else {
            return colors
        }
    }
}
