//
//  ColorListViewModel.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import RxSwift

import JSInject

class ColorListViewModel: BaseViewModel, ViewModel {
    // MARK: - Input
    struct Input {
        let refresh: PublishSubject<Void> = PublishSubject()
        let toggleFilter: PublishSubject<Void> = PublishSubject()
    }
    let input: Input = Input()
    
    // MARK: - Output
    struct Output {
        let colors: Observable<[Color]>
        let isFiltered: Observable<Bool>
        let isLoading: Observable<Bool>
        let error: Observable<String?>
    }
    let output: Output
    
    // MARK: - State
    
    // MARK: - Property
    @Inject()
    private var colorService: ColorServiceProtocol
    
    // MARK: - Constructor
    override init() {
        let colors = BehaviorSubject<[Color]>(value: [])
        let isFiltered = BehaviorSubject<Bool>(value: false)
        let isLoading = BehaviorSubject<Bool>(value: false)
        let error = BehaviorSubject<String?>(value: nil)
        
        output = Output(
            colors: colors,
            isFiltered: isFiltered,
            isLoading: isLoading,
            error: error
        )
        
        super.init()
        
        // Refresh trigger
        let refresh = input.refresh
            .withLatestFrom(isFiltered)
        
        // Toggle filter trigger
        let toggleFilter = input.toggleFilter
            .withLatestFrom(isFiltered) { !$1 }
            .share()
            
        // Toggle filter state
        toggleFilter.bind(to: isFiltered)
            .disposed(by: disposeBag)
        
        // Request colors
        Observable.merge(refresh, toggleFilter)
            .withLatestFrom(isLoading) { ($0, $1) }
            .filter { _, isLoading in !isLoading }
            .flatMap { [weak self] isFiltered, _ -> Observable<[Color]> in
                isLoading.onNext(true)
                return (self?.fetchColors(with: isFiltered) ?? .empty())
                    .do(onError: { error.onNext($0.localizedDescription) })
                    .catchError { _ in .empty() }
                    .do(onCompleted: { isLoading.onNext(false) })
            }
            .bind(to: colors)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func fetchColors(with isFiltered: Bool) -> Observable<[Color]> {
        colorService.fetchColors(with: isFiltered)
            .asObservable()
    }
    
    deinit {
        Logger.verbose()
    }
}
