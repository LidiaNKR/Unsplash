//
//  RandomPhotoCollectionViewController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class RandomPhotoCollectionViewController: UICollectionViewController {
    
    //MARK: - Private properties
    private lazy var inset: CGFloat = 10
    private lazy var sectionInserts = UIEdgeInsets(top: 20,
                                              left: 20,
                                              bottom: 20,
                                              right: 20)
    private lazy var cellWidth: CGFloat = (self.view.frame.width - 6 * inset) / 2
    private lazy var cellHeight: CGFloat = cellWidth
    
    private let searchController = SearchController()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(RandomCollectionViewCell.self, forCellWithReuseIdentifier: RandomCollectionViewCell.identifier)
        collectionView.backgroundColor = .red
        title = "Главная"
        
        navigationItem.searchController = searchController
        setupNavigationBar()
    }
    
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func setupNavigationBar() {

        title = "Главная"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
}
