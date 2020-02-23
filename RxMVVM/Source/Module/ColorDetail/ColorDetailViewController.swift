//
//  ColorDetailViewController.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ColorDetailViewController: BaseViewController<ColorDetailViewModel, ColorDetailViewCoordinator>, ViewControllable {
    // MARK: - View property
    private var colorDetailView: ColorDetailView { view as! ColorDetailView }
    
    private var colorView: UIView { colorDetailView.colorView }
    private var colorNameLabel: UILabel { colorDetailView.colorNameLabel }
    private var colorHexLabel: UILabel { colorDetailView.colorHexLabel }
    
    // MARK: - Property
    
    // MARK: - Lifecycle
    override func loadView() {
        view = ColorDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Bind
    override func bind(_ viewModel: ColorDetailViewModel) {
        // MARK: Input
        
        // MARK: Output
        // Title
        viewModel.name
            .drive(rx.title)
            .disposed(by: disposeBag)
        
        // Color
        viewModel.hex
            .map { UIColor(hex: $0) }
            .drive(colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        // Name
        viewModel.name
            .drive(colorNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Hex
        viewModel.hex
            .drive(colorHexLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    deinit {
        Logger.verbose()
    }
}
