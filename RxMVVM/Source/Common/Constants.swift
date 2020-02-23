//
//  Constants.swift
//  RxMVVM
//
//  Created by JSilver on 2020/02/23.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

enum Constants {
    // MARK: - App constant
    
    // MARK: - Resource
    enum Resource {
        enum Font {
            static let headline: UIFont = .systemFont(ofSize: 24, weight: .black)
            static let body: UIFont = .systemFont(ofSize: 17, weight: .regular)
        }
        
        enum Color {
            static let clear: UIColor = .clear
            
            static let background: UIColor = UIColor(named: "Background")!
            static let groupedBackground: UIColor = UIColor(named: "Grouped Background")!
            
            static let primary: UIColor = UIColor(named: "Primary")!
        }
    }
}
