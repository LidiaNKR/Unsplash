//
//  APIURL.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 19.07.2023.
//

import Foundation

enum APIURL {
    case randomPhotos(count: Int)
    case searchPhoto(query: String, orderBy: String, count: Int)
    
    var url: URL? {
        let baseURL = APIConstant.baseURL
        let asccessKey = APIConstant.accessKey
        
        switch self {
        case .randomPhotos(count: let count):
            let url = baseURL + "/photos/random?count=\(count)" + "&client_id=" + asccessKey
            return URL(string: url)
        case .searchPhoto(query: let query, orderBy: let orderBy, count: let count):
            let url = baseURL + "/search/photos?query=\(query)&order_by=\(orderBy)&per_page=\(count)" + "&client_id=" + asccessKey
            return URL(string: url)
        }
    }
}
