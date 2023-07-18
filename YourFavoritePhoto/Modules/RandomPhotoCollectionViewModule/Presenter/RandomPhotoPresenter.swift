//
//  RandomPhotoPresenter.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 26.06.2023.
//

import Foundation

protocol RandomPhotoCollectionViewProtocol: AnyObject {
    func success()
//    func failure(error: Error)
}

protocol RandomPhotoPresenterProtocol: AnyObject {
    init(view: RandomPhotoCollectionViewProtocol, dataFetcherService: DataFetcherServiceProtocol, router: RouterProtocol)
    var gallery: [GalleryElement]? { get set }
    func fetchGallery()
    func tapOnTheRandomPhoto(gallery: GalleryElement?)
    func sizeForPhoto(for indexPath: IndexPath) -> CGSize
}

final class RandomPhotoPresenter: RandomPhotoPresenterProtocol {
    weak var view: RandomPhotoCollectionViewProtocol?
    let router: RouterProtocol?
    let dataFetcherService: DataFetcherServiceProtocol
    var gallery: [GalleryElement]?
    
    required init(view: RandomPhotoCollectionViewProtocol, dataFetcherService: DataFetcherServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.dataFetcherService = dataFetcherService
        self.router = router
        fetchGallery()
    }
    
    func fetchGallery() {
        dataFetcherService.fetchGallery { [weak self] gallery in
            guard let self = self else { return }
            self.gallery = gallery
            self.view?.success()
        }
    }
    
    func tapOnTheRandomPhoto(gallery: GalleryElement?) {
        router?.showRandomPhotoDetail(galleryElement: gallery)
    }
    
    func sizeForPhoto(for indexPath: IndexPath) -> CGSize {
        let width = gallery?[indexPath.row].width ?? 180
        let height = gallery?[indexPath.row].height ?? 180
        return CGSize(width: width, height: height)
    }

}
