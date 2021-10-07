//
//  CellViewModel.swift
//  CatsFeed
//
//  Created by Apple on 06.10.2021.
//

import Foundation

class PostCellViewModel: PostCellViewModelProtocol {

    private var post: Post

    var imageUrl: String {
        return post.urls.regular
    }

    var description: String {
        return post.description ?? "No description, good day✌️"
    }

    init (post: Post) {
        self.post = post
    }
}
