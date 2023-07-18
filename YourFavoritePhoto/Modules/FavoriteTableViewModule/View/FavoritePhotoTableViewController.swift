//
//  FavoritePhotoTableViewController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class FavoritePhotoTableViewController: UITableViewController {
    
    //MARK: - Private properties
    private let searchController = SearchController()
    
    //MARK: - Public properties
    var presenter: FavoritePhotoPresenterProtocol!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        tableView.rowHeight = 100
        navigationItem.searchController = searchController
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        success()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.favoritePhotoCount()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath)  as? FavoriteTableViewCell else { return UITableViewCell() }
        
        let currentFavoritephoto = presenter.favoritePhotoGallery[indexPath.row]
        cell.configure(photo: currentFavoritephoto.image, userName: currentFavoritephoto.user)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentFavoritePhoto = presenter.favoritePhotoGallery[indexPath.row]
        presenter.tapOnTheFavoritePhoto(favoritePhotoGallery: currentFavoritePhoto)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let currentFavoritePhoto = presenter.favoritePhotoGallery[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            self.presenter.deleteFavoritePhoto(favoritePhoto: currentFavoritePhoto)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - Private methods
    private func setupNavigationBar() {

        title = "Избранное"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        // Добавление кнопки редактирования на экране
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(edit)
        )
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func edit() {
    }
}

    //MARK: - Extensions
extension FavoritePhotoTableViewController: FavoritePhotoTableViewProtocol {
    func success() {
        tableView.reloadData()
    }
}
