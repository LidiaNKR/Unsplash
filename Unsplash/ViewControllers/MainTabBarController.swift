//
//  MainTabBarController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        let layout = UICollectionViewFlowLayout()
        viewControllers = [
            generateCollectionVC(
                viewController: UINavigationController(rootViewController:
                                                        RandomPhotoCollectionViewController(collectionViewLayout: layout)),
                title: "Главная",
                image: UIImage(systemName: "house.fill")
            ),
            generateCollectionVC(
                viewController: UINavigationController(rootViewController:
                                                        FavoritPhotoTableViewController()),
                title: "Избранное",
                image: UIImage(systemName: "star.fill")
            )
        ]
    }
    
    private func generateCollectionVC(viewController: UINavigationController, title: String, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2

        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )

        roundLayer.path = bezierPath.cgPath

        tabBar.layer.insertSublayer(roundLayer, at: 0)

        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor.white.cgColor
    }
}

