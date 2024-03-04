//
//  QAError.swift
//  QuotesApp
//
//  Created by Mikhail Ustyantsev on 04.03.2024.
//

import Foundation

enum QAError: String, Error {
    case invalidURL         = "This URL is invalid. Please try again"
    case unableToComplete   = "Unable to connect your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again"
    case invalidData        = "Data received from the server was invalid. Please try again"
}
