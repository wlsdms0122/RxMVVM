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
    }
}
