//
//  DataFetcherService.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 14.06.2023.
//

import Foundation

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchGallery(completion: @escaping (Gallery?) -> Void) {
        let urlGallery = URLS.unsplashApi.rawValue
        networkDataFetcher.fetchGenericJSONData(urlString: urlGallery, response: completion)
    }
}
