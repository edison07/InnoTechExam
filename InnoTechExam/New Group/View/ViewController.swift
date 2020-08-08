//
//  ViewController.swift
//  InnoTechExam
//
//  Created by edisonlin on 2020/8/7.
//  Copyright © 2020 edison. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getData()
        setupSearchController()
    }
    
    private func setupSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        self.tableView.tableHeaderView = self.searchController.searchBar
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CustomTableViewCell.self, for: indexPath)
        cell.thumbnailImageView.kf.setImage(with: viewModel.imageURL(at: indexPath.row))
        cell.contentLabel.text = viewModel.title(at: indexPath.row)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
}

extension ViewController: ViewModelDelegate {
    
    func viewModelDidGetData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        viewModel.filterData(text: searchString)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.shouldShowSearchResults = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.shouldShowSearchResults = true
    }
}

extension ViewController: UISearchControllerDelegate {
    
    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.shouldShowSearchResults = false
    }
}
