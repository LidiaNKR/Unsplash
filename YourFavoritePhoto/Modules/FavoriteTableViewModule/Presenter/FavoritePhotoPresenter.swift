//
//  FavoritePhotoPresenter.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 26.06.2023.
//

import RealmSwift

protocol FavoritePhotoTableViewProtocol: AnyObject {
    func success()
}

protocol FavoritePhotoPresenterProtocol: AnyObject {
    init(view: FavoritePhotoTableViewProtocol, storageManager: StorageManagerProtocol, router: RouterProtocol)
    var favoritePhotoGallery: Results<FavoritePhoto>! { get set }
    func favoritePhotoCount() -> Int
    func fetchFavoritePhoto()
    func deleteFavoritePhoto(favoritePhoto: FavoritePhoto)
    func tapOnTheFavoritePhoto(favoritePhotoGallery: FavoritePhoto)
}

final class FavoritePhotoPresenter: FavoritePhotoPresenterProtocol {
    unowned var view: FavoritePhotoTableViewProtocol?
    let router: RouterProtocol?
    let storageManager: StorageManagerProtocol
    var favoritePhotoGallery: Results<FavoritePhoto>!
    
    required init(view: FavoritePhotoTableViewProtocol, storageManager: StorageManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.storageManager = storageManager
        self.router = router
        self.favoritePhotoGallery = storageManager.realm.objects(FavoritePhoto.self)
        fetchFavoritePhoto()
    }
    
    func favoritePhotoCount() -> Int {
        favoritePhotoGallery.count
    }
    
    func fetchFavoritePhoto() {
        view?.success()
    }
    
    func deleteFavoritePhoto(favoritePhoto: FavoritePhoto) {
        storageManager.delete(favoritePhoto: favoritePhoto)
    }
    
    func tapOnTheFavoritePhoto(favoritePhotoGallery: FavoritePhoto) {
        router?.showFavoritePhotoDetail(favoritePhoto: favoritePhotoGallery)
    }
}
