//
//  DataFetcher.swift
//  CatsFeed
//
//  Created by Apple on 06.10.2021.
//

import Foundation

class DataFetcher {

    static var shared = DataFetcher()

    var networkManager = NetworkManager()

    func fetchPosts(topicSearch: String, photosPage: Int?, completion: @escaping (APIResponse?) -> ()) {
        networkManager.request(topicSearch: topicSearch, photosPage: photosPage) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            let decode = self.decodeJSON(type: APIResponse.self, from: data)
            DispatchQueue.main.async {
                completion(decode)}
        }
    }

    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }

        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
