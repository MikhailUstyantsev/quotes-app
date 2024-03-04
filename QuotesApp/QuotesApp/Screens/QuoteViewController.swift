//
//  QuoteViewController.swift
//  QuotesApp
//
//  Created by Mikhail Ustyantsev on 04.03.2024.
//

import UIKit


final class QuoteViewController: UIViewController {
    
    let quoteLabel  = QATitleLabel()
    let authorLabel = QABodyLabel(textAlignment: .center)
    
    let quote: Quote
    
    init(quote: Quote) {
        self.quote = quote
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureLabels()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func  configureLabels() {
        view.addSubview(quoteLabel)
        view.addSubview(authorLabel)
        
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            quoteLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            quoteLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            quoteLabel.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.8),
            
            authorLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 20),
        ])
        
        quoteLabel.textAlignment = .center
        quoteLabel.font          = Fonts.futuraMediumItalic(with: 30)
        
        quoteLabel.text          = "\"\(quote[0].quote)\""
        authorLabel.text         = quote[0].author
    }
    
}
