//
//  FavoritePhoto.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 14.06.2023.
//

import RealmSwift

final class FavoritePhoto: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var image = ""
    @objc dynamic var location = ""
    @objc dynamic var user = ""
    @objc dynamic var createdAt = ""
    @objc dynamic var downloads = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

