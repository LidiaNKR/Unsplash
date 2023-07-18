//
//  DetailPhotoPresenter.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 26.06.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func configure(image: String, createAt: String, description: String)
    func setInitialImage(image: String)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, router: RouterProtocol)
    func configure(image: String, createAt: String, username: String, location: String, downloads: Int)
}

final class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let router: RouterProtocol?
    
    required init(view: DetailViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func configure(image: String, createAt: String, username: String, location: String, downloads: Int) {
        let image = image
        let createAt = String(createAt.prefix(10))
        let description = """
                        Автор: \(username)
                        Страна: \(location)
                        Скачиваний: \(downloads)
                        """
        view?.configure(image: image, createAt: createAt, description: description)
        view?.setInitialImage(image: image)
    }
}
