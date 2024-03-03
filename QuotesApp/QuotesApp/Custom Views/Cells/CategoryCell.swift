//
//  CategoryCell.swift
//  QuotesApp
//
//  Created by Mikhail Ustyantsev on on 04.03.2024.
//

import UIKit

class CategoryCell: UITableViewCell {

    static let reuseID  = "CategoryCell"
    let titleLabel      = QATitleLabel(textAlignment: .left, fontSize: 22)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(category: String) {
        titleLabel.text         = category.capitalized
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text         = nil
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    
}
