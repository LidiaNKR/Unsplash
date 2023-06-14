//
//  GalleryElement.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 13.06.2023.
//

import Foundation

typealias Gallery = [GalleryElement]

// MARK: - PhotoElement
struct GalleryElement: Decodable {
    let createdAt: String? //дата создания
    let width, height: Int? //ширина/высота картинки
    let description: String? //описание
    let urls: Image //картинки
    let user: User //имя пользователя и его локация

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case width, height, description, urls, user
    }
}

// MARK: - User
struct User: Decodable {
    let username: String?
    let location: String?
}

 // MARK: - Urls
struct Image: Decodable {
    let regular: String?
}

//Ссылка на JSON
enum URLS: String {
    case unsplashApi = "https://api.unsplash.com/photos/?client_id="
}

