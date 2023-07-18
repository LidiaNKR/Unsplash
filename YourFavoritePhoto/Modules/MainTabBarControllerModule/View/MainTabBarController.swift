//
//  MainTabBarController.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 11.06.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    //MARK: - Public properties
    var presenter: MainTabBarPresenterProtocol!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

    //MARK: - Extension
extension MainTabBarController: MainTabBarProtocol {
    func generateViewController() {
    }
}

