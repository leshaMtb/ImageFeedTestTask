
//
//  NetworkManager.swift
//  CatsFeed
//
//  Created by Apple on 06.10.2021.
//

import Foundation

//использую стандартный NetworkManager
class NetworkManager {

    let session = URLSession.shared

    func request(topicSearch: String, photosPage: Int?, completion: @escaping (Data?, Error?) -> Void)  {
        let parameters = self.prepareParaments(topicSearch: topicSearch, photosPage: photosPage)
        let url = self.createUrl(with: parameters)
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID tFLrSv6XaYbTZOAtfV0nyVpVdjM1dyTXghT1uASt9fE"
        return headers
    }

    private func prepareParaments(topicSearch: String?, photosPage: Int?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = topicSearch
        //на одной странице содержится только 10 фотографий, необходимо подгружать новые страницы
        parameters["page"] = String(photosPage ?? 1)
        return parameters
    }


    private func createUrl(with params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
