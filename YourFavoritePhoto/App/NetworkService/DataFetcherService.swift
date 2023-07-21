//
//  DataFetcherService.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 14.06.2023.
//

import Foundation

protocol DataFetcherServiceProtocol {
    ///Получение рандомных фотографий
    /// - Parameters:
    ///   - count: Количество получаемых фотографий (максимально - 30).
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func fetchGallery(count: Int, completion: @escaping (Result<[GalleryElement]?, Error>) -> Void)
    
    /// Получение результата по поиску фотографий.
    /// - Parameters:
    ///   - query: Условие поиска.
    ///   - orderBy: Вариант сортировки фотографий ("latest" и "relevant").
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func searchPhoto(query: String, orderBy: String, completion: @escaping (Result<SearchPhoto?, Error>) -> Void)
}

final class DataFetcherService: DataFetcherServiceProtocol {
    var networkDataFetcher: NetworkDataFetcherProtocol
    
    init(networkDataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchGallery(count: Int, completion: @escaping (Result<[GalleryElement]?, Error>) -> Void) {
        guard let url = APIURL.randomPhotos(count: count).url else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
    
    func searchPhoto(query: String, orderBy: String, completion: @escaping (Result<SearchPhoto?, Error>) -> Void) {
        guard let url = APIURL.searchPhoto(query: query, orderBy: orderBy, count: APIConstant.elementCount).url else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, completion: completion)
    }
}
