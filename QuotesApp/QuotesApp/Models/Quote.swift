//
//  Quote.swift
//  QuotesApp
//
//  Created by Mikhail Ustyantsev on 04.03.2024.
//

import Foundation

typealias Quote = [QuoteElement]

struct QuoteElement: Codable {
    let quote: String
    let author: String
    let category: String
}


