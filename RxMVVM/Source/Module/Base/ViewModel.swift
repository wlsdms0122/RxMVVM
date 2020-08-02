//
//  ViewModel.swift
//  RxMVVM
//
//  Created by JSilver on 2020/08/02.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    
    var disposeBag: DisposeBag { get }
}
