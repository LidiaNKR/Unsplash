//
//  AssemblerModuleBuilder.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 26.06.2023.
//

import UIKit

protocol AssemblerBuilderProtocol {
    func createTabBarModule(router: RouterProtocol) -> UITabBarController
    func createRandomCollectionViewModule(layout: UICollectionViewFlowLayout, router: RouterProtocol) -> UICollectionViewController
    func createFavoriteTableViewModule(router: RouterProtocol) -> UITableViewController
    func createDetailRandomPhotoViewModule(gallery: GalleryElement?, router: RouterProtocol) -> UIViewController
    func createDetailFavoritePhotoViewModule(favoritePhoto: FavoritePhoto?, router: RouterProtocol) -> UIViewController
}

final class AssemblerModuleBuilder: AssemblerBuilderProtocol {
    
    func createTabBarModule(router: RouterProtocol) -> UITabBarController {
        let view = MainTabBarController()
        return view
    }
    
    func createRandomCollectionViewModule(layout: UICollectionViewFlowLayout, router: RouterProtocol) -> UICollectionViewController {
        let view = RandomPhotoCollectionViewController(collectionViewLayout: layout)
        let dataFetcherService = DataFetcherService()
        let presenter = RandomPhotoPresenter(view: view, dataFetcherService: dataFetcherService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createFavoriteTableViewModule(router: RouterProtocol) -> UITableViewController {
        let view = FavoritePhotoTableViewController()
        let storageManager = StorageManager()
        let presenter = FavoritePhotoPresenter(view: view, storageManager: storageManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailRandomPhotoViewModule(gallery: GalleryElement?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let storageManager = StorageManager()
        let presenter = DetailPresenter(view: view, router: router, storageManager: storageManager)
        presenter.configureGalleryDetailViewController(gallery: gallery)
        view.presenter = presenter
        return view
    }
    
    func createDetailFavoritePhotoViewModule(favoritePhoto: FavoritePhoto?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let storageManager = StorageManager()
        let presenter = DetailPresenter(view: view, router: router, storageManager: storageManager)
        presenter.configureFavoriteDetailViewController(favoritePhoto: favoritePhoto)
        view.presenter = presenter
        return view
    }
}
