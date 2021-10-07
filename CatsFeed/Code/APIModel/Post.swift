//
//  Post.swift
//  CatsFeed
//
//  Created by Apple on 06.10.2021.
//

import Foundation

 struct APIResponse: Codable {
  let results: [Post]
}

struct PostUserProfileImage: Codable {
  let medium: String
}

struct PostUser: Codable {
  let profile_image: PostUserProfileImage
}

struct PostUrls: Codable {
  let regular: String
}

struct Post: Codable {
  let id: String
  let description: String?
  let user: PostUser
  let urls: PostUrls
}
