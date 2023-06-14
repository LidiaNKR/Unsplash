//
//  RandomPhotoCollectionViewController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class RandomPhotoCollectionViewController: UICollectionViewController {
    
    //MARK: - Private properties
    private lazy var inset: CGFloat = 2
    private lazy var sectionInserts = UIEdgeInsets(top: 5,
                                              left: 5,
                                              bottom: 5,
                                              right: 5)
    private lazy var cellWidth: CGFloat = (self.view.frame.width - 10 * inset) / 2
    private lazy var cellHeight: CGFloat = cellWidth
    
    private let searchController = SearchController()
    
    private let dataFetcherService = DataFetcherService()
    var photos: Gallery?
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(RandomCollectionViewCell.self, forCellWithReuseIdentifier: RandomCollectionViewCell.identifier)
        collectionView.backgroundColor = .red

        navigationItem.searchController = searchController
        setupNavigationBar()
        
        dataFetcherService.fetchGallery { (photo) in
            self.photos = photo
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isFiltering ? searchController.filteredPhoto.count : photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomCollectionViewCell.identifier, for: indexPath)  as? RandomCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = searchController.isFiltering ? searchController.filteredPhoto[indexPath.item] : photos?[indexPath.item]
        cell.configure(with: photo)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        detailViewController.photo = searchController.isFiltering ? searchController.filteredPhoto[indexPath.item] : photos?[indexPath.item]
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
}

    // MARK: - UICollectionViewDelegateFlowLayout
extension RandomPhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left / 2
    }
}

