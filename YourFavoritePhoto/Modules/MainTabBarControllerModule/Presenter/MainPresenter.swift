//
//  MainPresenter.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 26.06.2023.
//

import Foundation

protocol MainTabBarProtocol: AnyObject {
    func generateViewController()
}

protocol MainTabBarPresenterProtocol: AnyObject {
    init (view: MainTabBarProtocol, router: RouterProtocol)
    func generateTabBar()
}

class MainPresenter: MainTabBarPresenterProtocol {
    weak var view: MainTabBarProtocol?
    let router: RouterProtocol?
    
    required init(view: MainTabBarProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func generateTabBar() {
        view?.generateViewController()
    }
}
