//
//  NetworkService.swift
//  Unsplash
//
//  Created by Лидия Ладанюк on 13.06.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    ///Запрос данных по URL
    /// - Parameters:
    ///   - url: URL запроса.
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func request(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func request(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        })
    }
}
