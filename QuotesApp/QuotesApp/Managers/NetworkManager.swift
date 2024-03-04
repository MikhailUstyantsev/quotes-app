//
//  NetworkManager.swift
//  QuotesApp
//
//  Created by Mikhail Ustyantsev on 04.03.2024.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getQuote(for category: String, completed: @escaping (Result<Quote, QAError>) -> Void) {
        let endpoint = "https://api.api-ninjas.com/v1/quotes?category=\(category.lowercased())"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("0TPQLCv5NSUkYKlXN/yFIQ==TEmEw7ri8ZSi2RDB", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder   = JSONDecoder()
                let quote  = try decoder.decode(Quote.self, from: data)
                completed(.success(quote))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
