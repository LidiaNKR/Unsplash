//
//  DetailPhotoPresenter.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 26.06.2023.
//

import RealmSwift

protocol DetailViewProtocol: AnyObject {
    ///Установка значений элементов интерфейса.
    ///   - Parameters:
    ///   - image: URL адрес текущей фотографии
    ///   - createAt: дата загрузки фотографии
    ///   - description: описание
    ///   (имя пользователя, локация, количество скачиваний)
    func configureDetailViewController(image: String,
                                       createAt: String,
                                       description: String)
    
    ///Установка картинки внешнего вида кнопки LikeButton
    ///   - Parameters:
    ///   - imageName: принимает название картинки внешнего вида LikeButton
    func setImageLikeButton(imageName: String)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol,
         router: RouterProtocol,
         storageManager: StorageManagerProtocol)
    var galleryElement: GalleryElement? { get }
    var favoritePhotoElement: FavoritePhoto? { get }
    
    ///Есть ли фотография в списке избранных фото в Realm? Да/Нет
    var isFavotitePhoto: Bool { get }
    
    ///URL ссылка текущей фотографии
    var currentImageURL: String { get }
    
    ///Конфигурация значений для элементов интерфейса DetailView
    ///   - Parameters:
    ///   - gallery: элемент модели данных GalleryElement
    ///   (фотография из списка рандомных фото, загружаемых из сети).
    func configureGalleryDetailViewController(gallery: GalleryElement?)
    
    ///Конфигурация значений для элементов интерфейса DetailView
    ///   - Parameters:
    ///   - favoritePhoto: элемент модели данных FavoritePhoto
    ///   (избранные фото, сохраненные в Realm).
    func configureFavoriteDetailViewController(favoritePhoto: FavoritePhoto?)
    
    ///Конфигурация отображения значений для элементов интерфейса.
    ///   - Parameters:
    ///   - image: URL адрес текущей фотографии
    ///   - createAt: дата загрузки фотографии
    ///   - user: имя пользователя загруженной фотографии
    ///   - location: локация фотографии
    ///   - downloads: количество скачиваний фотографии
    func configureView(image: String,
                       createAt: String,
                       user: String,
                       location: String,
                       downloads: Int)
    
    ///Проверка наличия фотографии в БД Realm.
    ///   - Parameters:
    ///   - imageURL: URL адрес текущей фотографии в String формате.
    func setInitialImage(imageURL: String)
    
    ///Конфигурация картинки внешнего вида LikeButton
    ///При наличии фото в БД - "favImage", при отсуствии - "UnFavImage"
    func setImage()
    
    ///Изменение статуса "избранное фото" по нажатию на кнопку LikeButton. Да/нет
    ///Cохранение/удаление ImageURL из базы Realm
    ///Установка актуальной картинки внешнего вида LikeButton
    func pressed()
    
    ///Сохранение текущей фотографии в Realm
    func savePhoto()
    
    ///Удаление текущей фотографии из Realm
    func deletePhoto()
}

final class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let router: RouterProtocol?
    
    var galleryElement: GalleryElement?
    var storageManager: StorageManagerProtocol
    
    var favoritePhotoElement: FavoritePhoto?
    let favoritePhotoBase: Results<FavoritePhoto>!
    
    var isFavotitePhoto: Bool = false
    var currentImageURL: String = ""
    
    required init(view: DetailViewProtocol,
                  router: RouterProtocol,
                  storageManager: StorageManagerProtocol) {
        self.view = view
        self.router = router
        self.storageManager = storageManager
        favoritePhotoBase = storageManager.realm.objects(FavoritePhoto.self)
    }

    func configureGalleryDetailViewController(gallery: GalleryElement?) {
        galleryElement = gallery
        guard let gallery = gallery else { return }
        configureView(image: gallery.urls.regular ?? "",
                      createAt: gallery.createdAt ?? "",
                      user: gallery.user.username ?? "",
                      location: gallery.user.location ?? "",
                      downloads: gallery.downloads ?? 0)
    }
    
    func configureFavoriteDetailViewController(favoritePhoto: FavoritePhoto?) {
        favoritePhotoElement = favoritePhoto
        guard let favoritePhoto = favoritePhoto else { return }
        configureView(image: favoritePhoto.image,
                      createAt: favoritePhoto.createdAt,
                      user: favoritePhoto.user,
                      location: favoritePhoto.location,
                      downloads: favoritePhoto.downloads)
    }
    
    func configureView(image: String,
                       createAt: String,
                       user: String,
                       location: String,
                       downloads: Int) {
        let image = image
        let createAt = String(createAt.prefix(10))
        let description = """
                        Автор: \(user)
                        Страна: \(location)
                        Скачиваний: \(downloads)
                        """
        view?.configureDetailViewController(image: image,
                                            createAt: createAt,
                                            description: description)
        setInitialImage(imageURL: image)
    }
    
    func setInitialImage(imageURL: String) {
        currentImageURL = imageURL
        let isCurrentPhotoInBase = favoritePhotoBase.where {
            $0.image.contains("\(imageURL)")
        }
        
        if isCurrentPhotoInBase.isEmpty {
            isFavotitePhoto = false
            setImage()
        } else {
            isFavotitePhoto = true
            setImage()
        }
    }
    
    func setImage() {
        !isFavotitePhoto ?
        view?.setImageLikeButton(imageName: "UnFavImage") :
        view?.setImageLikeButton(imageName: "FavImage")
    }
    
    func pressed() {
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
    
    func savePhoto() {
        favoritePhotoElement = FavoritePhoto()
        guard let newFavoritePhoto = favoritePhotoElement else { return }
        guard let gallery = galleryElement else { return }
        newFavoritePhoto.image = gallery.urls.regular ?? ""
        newFavoritePhoto.user = gallery.user.username ?? ""
        newFavoritePhoto.location = gallery.user.location ?? ""
        newFavoritePhoto.downloads = gallery.downloads ?? 0
        newFavoritePhoto.createdAt = gallery.createdAt ?? ""
        
        DispatchQueue.main.async {
            self.storageManager.save(favoritePhoto: newFavoritePhoto)
        }
    }
    
    func deletePhoto() {
        guard let deletedCurrentFavoritePhoto =
                favoritePhotoBase.filter("image = '\(currentImageURL)'").first
        else { return }
        storageManager.delete(favoritePhoto: deletedCurrentFavoritePhoto)
    }
}
