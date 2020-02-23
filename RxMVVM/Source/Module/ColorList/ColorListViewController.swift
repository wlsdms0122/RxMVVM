//
//  ColorListViewController.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ColorListViewController: BaseViewController<ColorListViewModel, ColorListViewCoordinator>, ViewControllable {
    // MARK: - View property
    private var colorListView: ColorListView { view as! ColorListView }
    
    private var colorTableView: UITableView { colorListView.colorTableview }
    
    private var refreshButton: UIButton { colorListView.refreshButton }
    private var favoriteButton: UIButton { colorListView.favoriteButton }
    
    private var activityIndicator: UIActivityIndicatorView { colorListView.activityIndicator }
    
    // MARK: - Property
    private let dataSource = RxTableViewSectionedReloadDataSource<ColorListSection>(configureCell: { dataSource, tableView, indexPath, viewModel in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ColorListView.COLOR_LIST_CELL_IDENTIFIER, for: indexPath) as? ColorListCell else { fatalError() }
        cell.viewModel = viewModel
        return cell
    })
    
    // MARK: - Lifecycle
    override func loadView() {
        view = ColorListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "color_list_title".localized
    }

    // MARK: - Bind
    override func bind(_ viewModel: ColorListViewModel) {
        // MARK: Input
        rx.viewDidLoad
            .bind(to: viewModel.input.refresh)
            .disposed(by: disposeBag)
        
        refreshButton.rx.tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.refresh)
            .disposed(by: disposeBag)
        
        favoriteButton.rx.tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.toggleFilter)
            .disposed(by: disposeBag)
        
        colorTableView.rx.itemSelected
            .compactMap { [weak self] in self?.dataSource.sectionModels[$0.section].items[$0.item].color }
            .subscribe(onNext: { [weak self] in self?.coordinator.present(for: .detail(color: $0), animated: true) })
            .disposed(by: disposeBag)
        
        // MARK: Output
        // Sections
        viewModel.colors
            .drive(colorTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // Is filtered
        viewModel.isFiltered
            .drive(favoriteButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        // Loading
        viewModel.isLoading
            .drive(onNext: { [weak self] in $0 ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating() })
            .disposed(by: disposeBag)
        
        // Error
        viewModel.error
            .asObservable()
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] in
                let alertViewController = UIAlertController(title: nil, message: $0, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "common_confirm_title".localized, style: .default))
                
                self?.present(alertViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    deinit {
        Logger.verbose()
    }
}
