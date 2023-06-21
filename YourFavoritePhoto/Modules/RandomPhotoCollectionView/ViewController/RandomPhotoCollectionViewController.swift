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
    private let dataFetcherService = DataFetcherService()
    private var photos = Gallery()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(RandomCollectionViewCell.self, forCellWithReuseIdentifier: RandomCollectionViewCell.identifier)
        navigationItem.searchController = searchController
        setupNavigationBar()
        setupCollectionViewItemSize()
        
        dataFetcherService.fetchGallery { (photo) in
            guard let photo = photo else { return }
            self.photos = photo
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
            self.setupCollectionViewItemSize()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isFiltering ? searchController.filteredPhoto.count : photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomCollectionViewCell.identifier, for: indexPath)  as? RandomCollectionViewCell else { return UICollectionViewCell() }

        let photo = searchController.isFiltering ? searchController.filteredPhoto[indexPath.item].urls.small : photos[indexPath.item].urls.small
        cell.configure(with: photo)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        if searchController.isFiltering {
            let filteringItem = searchController.filteredPhoto[indexPath.item]
            detailViewController.image = filteringItem.urls.regular ?? ""
            detailViewController.configure(image: filteringItem.urls.regular ?? "", createAt: filteringItem.createdAt ?? "", user: filteringItem.user.username ?? "", location: filteringItem.user.location ?? "", downloads: filteringItem.downloads ?? 0)
        } else {
           let notfilteringItem = photos[indexPath.item]
            detailViewController.image = notfilteringItem.urls.regular ?? ""
            detailViewController.configure(image: notfilteringItem.urls.regular ?? "", createAt: notfilteringItem.createdAt ?? "", user: notfilteringItem.user.username ?? "", location: notfilteringItem.user.location ?? "", downloads: notfilteringItem.downloads ?? 0)
        }
        navigationController?.pushViewController(detailViewController, animated: true)
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
}
    
    // MARK: - UICollectionViewLayout
extension RandomPhotoCollectionViewController: WaterFallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width ?? 180
        let height = photos[indexPath.row].height ?? 180
        return CGSize(width: width, height: height)
    }
}

