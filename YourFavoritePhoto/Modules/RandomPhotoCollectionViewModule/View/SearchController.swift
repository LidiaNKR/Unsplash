//
//  SearchController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 12.06.2023.
//

import UIKit

final class SearchController: UISearchController, UISearchResultsUpdating {
    
    private var photos: [GalleryElement]?
    var filteredPhoto: [GalleryElement] = []
    
    //MARK: - Private properties
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    // MARK: - Private Methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        searchController.searchResultsUpdater = self
        filteredPhoto = photos?.filter { name in
            guard let author = name.description else { return false }
            return author.lowercased().contains(searchText.lowercased())
        } ?? []

        RandomPhotoCollectionViewController().collectionView.reloadData()
    }
}
