//
//  NetworkDataFetcher.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 13.06.2023.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    ///Получение общих данных по URL
    /// - Parameters:
    ///   - url: URL запроса.
    ///   - completion: Обработчик завершения, в который возвращается результат выполнения функции.
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (Result<T?, Error>) -> Void)
}

final class NetworkDataFetcher: NetworkDataFetcherProtocol {
    var networking: NetworkServiceProtocol
    
    init(networking: NetworkServiceProtocol = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (Result<T?, Error>) -> Void) {
        networking.request(url: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                print("Receive HTTP response error")
                return
            }
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(.failure(error))
            }
            
            
            guard self.errorHandler(httpResponse, completion: completion) else { return }
            print(httpResponse.statusCode, response?.url?.path ?? 0)

            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    private func errorHandler<T>(_ response: HTTPURLResponse, completion: ((Result<T, Error>) -> Void)) -> Bool {
        if response.statusCode == 200 {
            return true
        } else {
            guard let serverError = ServerError(rawValue: response.statusCode) else { return false }
            completion(.failure(serverError))
            return false
        }
    }
}

