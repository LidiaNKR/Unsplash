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
    }
        
    private func configureViewController(viewController: UINavigationController, title: String, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}

