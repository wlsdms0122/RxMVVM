//
//  ColorDetailView.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import SnapKit

class ColorDetailView: UIView {
    // MARK: - View property
    let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let colorNameLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Resource.Font.headline
        view.textAlignment = .center
        return view
    }()
    
    let colorHexLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Resource.Font.body
        view.textAlignment = .center
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
        
        [colorView, colorNameLabel, colorHexLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        colorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(colorView.snp.width)
        }
        
        colorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(colorView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(colorView)
        }
        
        colorHexLabel.snp.makeConstraints { make in
            make.top.equalTo(colorNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(colorView)
        }
    }
}
