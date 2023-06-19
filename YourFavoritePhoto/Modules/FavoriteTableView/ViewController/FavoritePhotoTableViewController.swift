//
//  FavoritePhotoTableViewController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit
import RealmSwift

final class FavoritePhotoTableViewController: UITableViewController {
    
    //MARK: - Private properties
    private let searchController = SearchController()
    private let storageManager = StorageManager.shared
    private var favoritePhoto: Results<FavoritePhoto>!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        tableView.backgroundColor = .blue
        tableView.rowHeight = 100
        navigationItem.searchController = searchController
        setupNavigationBar()
        
        favoritePhoto = storageManager.realm.objects(FavoritePhoto.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePhoto.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath)  as? FavoriteTableViewCell else { return UITableViewCell() }
        
        let currentFavoritephoto = favoritePhoto[indexPath.row]
        cell.configure(with: currentFavoritephoto)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
//        detailViewController.favPhoto = favoritePhoto[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let currentFavoritePhoto = favoritePhoto[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            self.storageManager.delete(favoritePhoto: currentFavoritePhoto)
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
