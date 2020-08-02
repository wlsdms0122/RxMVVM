//
//  ColorListCell.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ColorListCell: UITableViewCell {
    // MARK: - Constant
    static let IDENTIFIER: String = String(describing: ColorListCell.self)
    
    // MARK: - View property
    private let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let colorNameLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private let colorHexLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var textStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [colorNameLabel, colorHexLabel])
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    
    // MARK: - Property
    var viewModel: ColorListCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            bind(viewModel)
        }
    }
    
    private(set) var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    // MARK: - Bind
    func bind(_ viewModel: ColorListCellViewModel) {
        viewModel.output.hex
            .asDriver(onErrorJustReturn: "")
            .map { UIColor(hex: $0) }
            .drive(colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.output.name
            .asDriver(onErrorJustReturn: "")
            .drive(colorNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.hex
            .asDriver(onErrorJustReturn: "")
            .drive(colorHexLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setupLayout() {
        backgroundColor = Constants.Resource.Color.background
        
        [colorView, textStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        colorView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12).priority(.high)
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(colorView.snp.width)
        }
        
        textStackView.snp.makeConstraints { make in
            make.leading.equalTo(colorView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
    }
}
