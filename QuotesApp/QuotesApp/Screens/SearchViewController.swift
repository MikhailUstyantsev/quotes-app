//
//  SearchViewController.swift
//  QuotesApp
//
//  Created by Mikhail Ustyantsev on 04.03.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    let tableView               = UITableView()
    var searchArrRes: [String]  = []
    var searching               = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureTableView()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    func configureSearchController() {
        let searchController                        = UISearchController()
        searchController.searchBar.tintColor        = .systemPink
        searchController.searchResultsUpdater       = self
        searchController.searchBar.delegate         = self
        searchController.searchBar.placeholder      = "Search for a category"
        navigationItem.hidesSearchBarWhenScrolling  = false
        navigationItem.searchController             = searchController
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseID)
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        print(text)
        searchArrRes = QuotesCategories.originalCategories.filter { $0.localizedCaseInsensitiveContains(text)
        }
        if searchArrRes.count == 0 {
            searching = false
        } else {
            searching = true
        }
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        tableView.reloadData()
    }
    
    
    private func getQuote(_ category: String) {
        self.showLoadingView()
        NetworkManager.shared.getQuote(for: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let quote):
                self.dismissLoadingView()
                DispatchQueue.main.async {
                    let quoteViewController = QuoteViewController(quote: quote)
                    self.navigationController?.present(quoteViewController, animated: true)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchArrRes.count
            
        } else{
            return QuotesCategories.originalCategories.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseID, for: indexPath) as? CategoryCell else { return UITableViewCell() }
        var category = ""
        
        if searching {
            category = searchArrRes[indexPath.row]
        } else {
            category = QuotesCategories.originalCategories[indexPath.row]
        }
        
        cell.set(category: category)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var category = ""
        
        if searching {
            category = searchArrRes[indexPath.row]
        } else {
            category = QuotesCategories.originalCategories[indexPath.row]
        }
        self.getQuote(category)
    }
    
    
}
