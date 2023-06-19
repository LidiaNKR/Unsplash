//
//  LikeButton.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 13.06.2023.
//

import UIKit
import RealmSwift

final class LikeButton: UIButton {
    
    //MARK: - Private properties
    ///Доступ к менеджеру хранения
    private let storageManager = StorageManager.shared
    ///Доступ к текущей БД
    private var favoritePhotoBase: Results<FavoritePhoto>!
    ///Избранное фото? - да/нет
    private var isFavotitePhoto: Bool = false
    ///URL текущего фото
    var imageURL: String = ""
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        favoritePhotoBase = storageManager.realm.objects(FavoritePhoto.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    ///Установка Image в UIButton
    private func setImage(named: String) {
        self.setImage(UIImage(named: named), for: .normal)
    }
    
    ///Проверка текущего статуса ImageURL и установка изначальной картинки внешнего вида LikeButton
    func setInitialImage(imageURL: String) {
        ///Есть фото в базе Realm? Да/Нет
        let fav = favoritePhotoBase.where {
            $0.image.contains("\(imageURL)")
        }

        ///Установка картинки внешнего вида LikeButton, в завичимости от наличия ImageURL в БД Realm
        if fav.isEmpty {
            isFavotitePhoto = false
            setImage()
        } else {
            isFavotitePhoto = true
            setImage()
        }
    }
    
    ///Установка картинки внешнего вида LikeButton
    private func setImage() {
        if isFavotitePhoto {
            setImage(named: "FavImage")
        } else {
            setImage(named: "UnFavImage")
        }
    }
    
    ///Изменение статуса "избранное фото" по нажатию. Да/нет
    ///Cохранение/удаление ImageURL из базы Realm
    ///Установка актуальной картинки внешнего вида LikeButton
    @objc private func pressed() {
        if !isFavotitePhoto {
            savePhoto()
            isFavotitePhoto.toggle()
            setImage()
        } else {
            deletePhoto()
            isFavotitePhoto.toggle()
            setImage()
        }
    }
    
    ///Сохранение ImageURL в Realm
    private func savePhoto() {
        let newFavoritePhoto = FavoritePhoto()
        newFavoritePhoto.image = imageURL
        
        DispatchQueue.main.async {
            self.storageManager.save(favoritePhoto: newFavoritePhoto)
        }
    }
    
    ///Удаление ImageURL из Realm
    private func deletePhoto() {
        guard let currentFavoritePhoto = favoritePhotoBase.filter("image = '\(imageURL)'").first else {return}
        self.storageManager.delete(favoritePhoto: currentFavoritePhoto)
    }
}



