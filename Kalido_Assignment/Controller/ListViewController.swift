//
//  ListViewController.swift
//  Kalido_Assignment
//
//  Created by Ashish Baghel on 15/03/22.
//  Copyright © 2022 AshishBaghel. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet private (set) weak var tableView: UITableView!
    
    var items: [ListItemDisplayable]? {
        didSet {
            tableView.reloadData()
        }
    }
    
     var selectedArticle: Article?
    
    var filteredItems: [ListItemDisplayable]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var isFiltering: Bool {
        guard let searchText = searchText else { return false }
        return !searchText.isEmpty
    }
    
    var searchText: String? {
        didSet {
            guard let items = items, let searchText = self.searchText else { return }
            filteredItems = items.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUIApparance()
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArticleDetailViewController",
            let controller = segue.destination as? ArticleDetailViewController {
             controller.article = selectedArticle
        }
    }
    
    private func fetchData() {
        KalidoService().getListItems { [weak self] dataItems, error in
            guard let weakSelf = self else { return }
            if let dataItems = dataItems {
                weakSelf.items = dataItems
            } else {
                let alert = UIAlertController(title: "Sorry", message: "Something went wrong", preferredStyle: .alert)
                weakSelf.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setUIApparance() {
        title = "kalido Articles"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 121
        tableView.rowHeight = UITableView.automaticDimension
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type Author to search Article"
        navigationItem.searchController = searchController
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  isFiltering ? filteredItems?.count ?? 0 : items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableCell", for: indexPath) as? ArticleTableCell else { return UITableViewCell() }
        let item = isFiltering ? filteredItems?[indexPath.row] : items?[indexPath.row]
        cell.updateUI(with: item)
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = isFiltering ? filteredItems?[indexPath.row] as? Article : items?[indexPath.row] as? Article
        performSegue(withIdentifier: "ArticleDetailViewController", sender: nil)
    }
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.searchText = searchText
        print(searchText)
    }
}
