//
//  ColorListView.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import SnapKit

class ColorListView: UIView {
    // MARK: - View property
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    let colorTableview: UITableView = {
        let view = UITableView()
        
        view.register(ColorListCell.self, forCellReuseIdentifier: ColorListCell.IDENTIFIER)
        
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.tintColor = Constants.Resource.Color.primary
        view.imageView?.contentMode = .scaleAspectFit
        
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        
        view.imageView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    
    let refreshButton: UIButton = {
        let view = UIButton()
        view.tintColor = Constants.Resource.Color.primary
        view.imageView?.contentMode = .scaleAspectFit
        
        view.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        
        view.imageView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var footerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Resource.Color.clear
        
        [favoriteButton, refreshButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12).priority(.high)
            make.leading.equalToSuperview().inset(18)
            make.width.equalTo(28)
            make.height.equalTo(favoriteButton.snp.width)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12).priority(.high)
            make.trailing.equalToSuperview().inset(18)
            make.width.equalTo(28)
            make.height.equalTo(favoriteButton.snp.width)
        }
        
        return view
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.layer.shadow(alpha: 0.08, offset: CGSize(width: 0, height: -2))
        view.backgroundColor = Constants.Resource.Color.groupedBackground
        
        [footerContainerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        footerContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        return view
    }()
    
    // MARK: - Property
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setupLayout() {
        backgroundColor = Constants.Resource.Color.background
        
        [colorTableview, footerView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        colorTableview.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
        
        footerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
