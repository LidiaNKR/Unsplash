//
//  SearchPhoto.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 20.07.2023.
//

// MARK: - SearchPhoto
struct SearchPhoto: Decodable {
    let total: Int?
    let photos: [GalleryElement]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case photos = "results"
    }
}
