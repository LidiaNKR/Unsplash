//
//  RandomPhotoPresenter.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 26.06.2023.
//

import Foundation

protocol RandomPhotoCollectionViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    func setupCollectionViewItemSize()
}

protocol RandomPhotoPresenterProtocol: AnyObject {
    init(view: RandomPhotoCollectionViewProtocol,
         dataFetcherService: DataFetcherServiceProtocol,
         router: RouterProtocol)
    var gallery: [GalleryElement]? { get set }
    func fetchGallery()
    func fetchFilteredGallery(query: String, orderBy: String)
    func updateSearchResults(query: String)
    func tapOnTheRandomPhoto(gallery: GalleryElement?)
    func sizeForPhoto(for indexPath: IndexPath) -> CGSize
}

final class RandomPhotoPresenter: RandomPhotoPresenterProtocol {
    weak var view: RandomPhotoCollectionViewProtocol?
    let router: RouterProtocol?
    let dataFetcherService: DataFetcherServiceProtocol
    var gallery: [GalleryElement]?
    
    required init(view: RandomPhotoCollectionViewProtocol,
                  dataFetcherService: DataFetcherServiceProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.dataFetcherService = dataFetcherService
        self.router = router
        fetchGallery()
    }
    
    func fetchGallery() {
        dataFetcherService.fetchGallery(count: APIConstant.elementCount) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let gallery):
                self.gallery = gallery
                self.view?.success()
            case .failure(let error):
                if let serverError = error as? ServerError {
                    self.view?.failure(error: serverError)
                    print(serverError.errorDescription)
                    return
                }
            }
        }
    }
    
    func fetchFilteredGallery(query: String, orderBy: String) {
        gallery?.removeAll()
        dataFetcherService.searchPhoto(query: query, orderBy: orderBy) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let filteredPhoto):
                guard filteredPhoto?.total != 0 else {
                    print("no photo")
                    return
                }
                self.gallery = filteredPhoto?.photos
                self.view?.success()
            case .failure(let error):
                if let serverError = error as? ServerError {
                    self.view?.failure(error: serverError)
                    return
                }
            }
        }
    }
    
    func updateSearchResults(query: String) {
        view?.setupCollectionViewItemSize()
        if !query.isEmpty {
            gallery?.removeAll()
            fetchFilteredGallery(query: query, orderBy: "relevant")
            view?.success()
            view?.setupCollectionViewItemSize()
        } else {
            gallery?.removeAll()
            fetchGallery()
            view?.success()
            view?.setupCollectionViewItemSize()
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
