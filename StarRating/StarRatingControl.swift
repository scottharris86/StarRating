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
    private let componentActiveColor: UIColor = .red
    private let componentInactiveColor: UIColor = .gray
    private var stars: [UILabel] = []
    
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
        
        self.stars = stars
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchDragInside])
            updateValue(at: touch)
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else { return }
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchUpInside])
            updateValue(at: touch)
        } else {
            sendActions(for: [.touchUpOutside])
        }
        
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
    
    private func updateValue(at touch: UITouch) {
        
        for label in stars {
            let touchPoint = touch.location(in: label)
            if label.bounds.contains(touchPoint) {
                value = label.tag
                sendActions(for: [.valueChanged])
                label.textColor = componentActiveColor
                label.performFlare()
                for i in 1...label.tag {
                    let label = stars.filter { $0.tag == i }.first
                    if let label = label {
                        label.textColor = componentActiveColor
                    }
                    
                }
            } else {
                label.textColor = componentInactiveColor
            }
            
        }
    }
    
}

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        func spin() { transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2) }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare(); spin() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
