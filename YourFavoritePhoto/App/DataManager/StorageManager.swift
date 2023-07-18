//
//  StorageManager.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 14.06.2023.
//

import RealmSwift

protocol StorageManagerProtocol {
    var realm: Realm { get set }
    func save(favoritePhoto: FavoritePhoto)
    func delete(favoritePhoto: FavoritePhoto)
}

final class StorageManager: StorageManagerProtocol {
    var realm = try! Realm()

    // MARK: - Work with favorite photos
    ///Сохранение информации в БД
    func save(favoritePhoto: FavoritePhoto) {
        write {
            realm.add(favoritePhoto)
        }
    }
    
    ///Удаление информации из БД
    func delete(favoritePhoto: FavoritePhoto) {
        write {
            realm.delete(favoritePhoto)
        }
    }
    
    ///Запись операций в БД
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}
