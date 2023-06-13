//
//  MainTabBarController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    // MARK: - Private methods
    private func generateTabBar() {
        let layout = UICollectionViewFlowLayout()
        viewControllers = [
            generateViewController(
                viewController: UINavigationController(rootViewController:
                                                        RandomPhotoCollectionViewController(collectionViewLayout: layout)),
                title: "Главная",
                image: UIImage(systemName: "house.fill")
            ),
            generateViewController(
                viewController: UINavigationController(rootViewController:
                                                        FavoritePhotoTableViewController()),
                title: "Избранное",
                image: UIImage(systemName: "star.fill")
            )
        ]
    }
    
    private func generateViewController(viewController: UINavigationController, title: String, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}

