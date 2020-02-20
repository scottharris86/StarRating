//
//  StarRatingControl.swift
//  StarRating
//
//  Created by scott harris on 2/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit


@IBDesignable
class StarRatingControl: UIControl {
    
    // MARK: - Properties
    
    var value: Int = 1
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 5
    private let componentActiveColor: UIColor = .black
    private let componentInactiveColor: UIColor = .gray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        var stars: [UILabel] = []
        for i in 1...5 {
            let label = UILabel()
            let padding = CGFloat(8.0 * CGFloat(i))
               label.frame = CGRect(x: padding + (componentDimension * CGFloat(i - 1)), y: 0, width: componentDimension, height: componentDimension)
            
            let star = "⭑"
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            label.textAlignment = .center
            label.text = star
            if i == 1 {
                label.textColor = componentActiveColor
            } else {
                label.textColor = componentInactiveColor
            }
            label.tag = i
            stars.append(label)
            addSubview(label)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
}
