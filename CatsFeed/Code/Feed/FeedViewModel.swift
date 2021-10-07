//
//  FeedViewModel.swift
//  CatsFeed
//
//  Created by Apple on 06.10.2021.
//

import Foundation

class FeedViewModel {

    let neetworkDataFetcher = DataFetcher.shared
    var networkDataFetcher = DataFetcher()
    var page = 1
    //когда массив постов обновляется новыми мы добавляем новое время в массив timeOfDownloadArray,позже из него берем информацию для DetailVC
    var posts: [Post] = [] {
        didSet {
            timeOfDownloadArray.append(currentTime())
        }
    }
    var timeOfDownloadArray: [String] = []

    func currentTime() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        let currentTime = formatter.string(from: currentDateTime)
        return currentTime
    }

    func download(completion: @escaping() -> ()) {
        //можно выбрать любую topicSearch. В будущем можно добавить поисковую строку
        networkDataFetcher.fetchPosts(topicSearch: "dog", photosPage: 1) { [weak self] (apiResponse) in
            guard let apiResponseUnwrap = apiResponse else { return }
            self?.posts = apiResponseUnwrap.results
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func downloadMore(completion: @escaping() -> ()){
            page += 1
            networkDataFetcher.fetchPosts(topicSearch: "dog", photosPage: page) {[weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.posts.append(contentsOf: fetchedPhotos.results)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }


    func numberOfRows() -> Int {
        print("количество постов\(posts.count)")
        return posts.count
    }

    func cellViewModel(indexPath: IndexPath) -> PostCellViewModelProtocol? {
           let post = posts[indexPath.row]
           return PostCellViewModel(post: post)
       }

}
