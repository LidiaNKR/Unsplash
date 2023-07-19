//
//  RandomPhotoCollectionViewController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class RandomPhotoCollectionViewController: UICollectionViewController {
    
    //MARK: - Private properties
    private let searchController = SearchController()
    var presenter: RandomPhotoPresenterProtocol!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(RandomCollectionViewCell.self, forCellWithReuseIdentifier: RandomCollectionViewCell.identifier)
        navigationItem.searchController = searchController
        setupNavigationBar()
        setupCollectionViewItemSize()
        setupRefreshControl()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.setupCollectionViewItemSize()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isFiltering ? searchController.filteredPhoto.count : presenter.gallery?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomCollectionViewCell.identifier, for: indexPath)  as? RandomCollectionViewCell else { return UICollectionViewCell() }

        let photo = searchController.isFiltering ? searchController.filteredPhoto[indexPath.item].urls.small : presenter.gallery?[indexPath.item].urls.small
        cell.configure(with: photo)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let randomPhoto = presenter.gallery?[indexPath.row]
        presenter.tapOnTheRandomPhoto(gallery: randomPhoto)
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Главная"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    private func setupCollectionViewItemSize() {
        let layout = WaterFallLayout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление...")
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh() {
        presenter.gallery?.removeAll()
        presenter.fetchGallery()
        collectionView.reloadData()
        setupCollectionViewItemSize()
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

    //MARK: - Extension
extension RandomPhotoCollectionViewController: RandomPhotoCollectionViewProtocol {
    func success() {
        collectionView.reloadData()
    }
}

    // MARK: - UICollectionViewLayout
extension RandomPhotoCollectionViewController: WaterFallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        presenter.sizeForPhoto(for: indexPath)
    }
}

