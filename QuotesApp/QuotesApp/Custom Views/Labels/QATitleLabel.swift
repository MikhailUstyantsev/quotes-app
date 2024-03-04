//
//  QATitleLabel.swift
//  QuotesApp
//
//  Created by Mikhail Ustyantsev on 04.03.2024.
//

import UIKit

class QATitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    
    private func configure() {
        textColor                     = .label
        adjustsFontSizeToFitWidth     = true
        numberOfLines                 = 0
        minimumScaleFactor            = 0.9
        lineBreakMode                 = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
