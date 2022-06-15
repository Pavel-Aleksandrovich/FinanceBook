//
//  NetworkManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import Foundation

final class NetworkManager {
    
    private enum Api {
        static let current = "https://api.weatherapi.com/v1/current.json?key=1d91263cb358427082175537220406&q="
        static let history = "https://api.weatherapi.com/v1/history.json?key=1d91263cb358427082175537220406&q="
    }
    
    private enum EndPoints {
        static let date = "&dt="
        static let https = "https:"
    }
    
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
    }
}
//7d0b341870634da093c7dd7b06db9891
extension NetworkManager {
    func loadNews(completion: @escaping (Result<News, Error>) -> ()) {
        let api = "https://newsapi.org/v2/top-headlines?country=us&apiKey=7d0b341870634da093c7dd7b06db9891"
        
        self.loadData(api: api, completion: completion)
    }
    
    func loadImageDataFrom(url: String,
                           completion: @escaping (Result<Data, Error>) -> ()) {
        
        let correctUrlString = url
        guard let url = URL(string: correctUrlString) else { assert(false) }
        let request = URLRequest(url: url)
        
        self.session.downloadTask(with: request) { url, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let url = url else { return }
            do {
                let data = try Data(contentsOf: url)
                completion(.success(data))
            }
            catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

private extension NetworkManager {
    
    func loadData<T: Decodable>(api: String,
                                completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let url = URL(string: api) else { assert(false) }
        
        let request = URLRequest(url: url)
        
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let newData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newData))
            }
            catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
