//
//  ImageNetworkService.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 14.06.2023.
//

import Foundation

final class ImageNetworkService {
    
    //Класс является синглтоном
    static var shared = ImageNetworkService()
    
    private init() {}
    
    ///Парсим JSON - image
    func fetchImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            guard url == response.url else { return }
            
            completion(data, response)
            
        }.resume()
    }
}
