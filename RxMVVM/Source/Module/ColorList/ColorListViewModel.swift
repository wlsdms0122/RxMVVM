//
//  ColorListViewModel.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import JSInject

class ColorListViewModel: BaseViewModel {
    // MARK: - Input
    struct Input {
        let refresh: PublishRelay<Void> = PublishRelay()
        let toggleFilter: PublishRelay<Void> = PublishRelay()
    }
    
    // MARK: - Output
    var colors: Driver<[ColorListSection]> { _colors.asDriver() }
    var isFiltered: Driver<Bool> { _isFiltered.asDriver() }
    var isLoading: Driver<Bool> { _isLoading.asDriver() }
    var error: Driver<String?> { _error.asDriver() }
    
    // MARK: - State
    private let _colors: BehaviorRelay<[ColorListSection]> = BehaviorRelay(value: [])
    private let _isFiltered: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let _isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let _error: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // MARK: - Property
    var input: Input = Input()
    
    @Inject()
    private var colorService: ColorServiceProtocol
    
    // MARK: - Constructor
    override init() {
        super.init()
        
        let refreshTrigger = input.refresh
            .withLatestFrom(_isFiltered)
        
        let toggleFilterTrigger = input.toggleFilter
            .withLatestFrom(_isFiltered) { !$1 }
        
        let fetchColorsTrigger = Observable.merge(refreshTrigger, toggleFilterTrigger)
            .withLatestFrom(_isLoading) { ($1, $0) }
            .filter { !$0.0 }
            .map { $0.1 }
        
        let fetchColors = fetchColorsTrigger
            .flatMap { [weak self] isFiltered -> Observable<([Color], Bool)> in
                guard let self = self else { return .empty() }
                
                self._isLoading.accept(true)
                return self.colorService.fetchColors(with: isFiltered)
                    .asObservable()
                    .catchError { [weak self] in
                        self?._error.accept($0.localizedDescription)
                        return .empty()
                    }
                    .do(onCompleted: { [weak self] in self?._isLoading.accept(false) })
                    .map { ($0, isFiltered) }
            }
        
        fetchColors
            .map { ($0.map { ColorListCellViewModel(color: $0) }, $1) }
            .map { ([ColorListSection(model: Void(), items: $0)], $1) }
            .subscribe(onNext: { [weak self] in
                self?._colors.accept($0)
                self?._isFiltered.accept($1)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    deinit {
        Logger.verbose()
    }
}

typealias ColorListSection = SectionModel<Void, ColorListCellType>
typealias ColorListCellType = ColorListCellViewModel
