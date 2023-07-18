//
//  Router.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 26.06.2023.
//

import UIKit

protocol RouterRandomCollectionProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblerBuilder: AssemblerBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterRandomCollectionProtocol {
    func initialTabBarViewController()
    func showRandomPhotoDetail(galleryElement: GalleryElement?)
    func showFavoritePhotoDetail(favoritePhoto: FavoritePhoto?)
}

final class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var assemblerBuilder: AssemblerBuilderProtocol?
    let layout = UICollectionViewFlowLayout()
    
    init(navigationController: UINavigationController, assemblerBuilder: AssemblerBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblerBuilder = assemblerBuilder
    }
    
    func initialTabBarViewController() {
        if let navigationController = navigationController {
            guard let tabBarViewController = assemblerBuilder?.createTabBarModule(router: self) else { return }
            guard let randomPhotoCollectionViewController = assemblerBuilder?.createRandomCollectionViewModule(layout: layout, router: self) else { return }
            guard let favoritePhotoTableViewController = assemblerBuilder?.createFavoriteTableViewModule(router: self) else { return }
            tabBarViewController.viewControllers = [generateViewController(
                                viewController: UINavigationController(rootViewController:
                                                                        randomPhotoCollectionViewController),
                                title: "Главная",
                                image: UIImage(systemName: "house.fill")
                            ),
                            generateViewController(
                                viewController: UINavigationController(rootViewController:
                                                                        favoritePhotoTableViewController),
                                title: "Избранное",
                                image: UIImage(systemName: "star.fill")
                            )]
            navigationController.viewControllers = [tabBarViewController]
        }
    }
    
        private func generateViewController(viewController: UINavigationController, title: String, image: UIImage?) -> UINavigationController {
            viewController.tabBarItem.title = title
            viewController.tabBarItem.image = image
            return viewController
        }
    
    func showRandomPhotoDetail(galleryElement: GalleryElement?) {
        if let navigationController = navigationController {
            guard let detailRandomPhotoViewController = assemblerBuilder?.createDetailRandomPhotoViewModule(gallery: galleryElement, router: self) else { return }
            navigationController.pushViewController(detailRandomPhotoViewController, animated: true)
        }
    }
    
    func showFavoritePhotoDetail(favoritePhoto: FavoritePhoto?) {
        if let navigationController = navigationController {
            guard let detailFavoritePhotoViewController = assemblerBuilder?.createDetailFavoritePhotoViewModule(favoritePhoto: favoritePhoto, router: self) else { return }
            navigationController.pushViewController(detailFavoritePhotoViewController, animated: true)
        }
    }
}
