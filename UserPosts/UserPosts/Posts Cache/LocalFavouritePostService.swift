//
//  LocalFavouriteService.swift
//  UserPosts
//
//  Created by Preetham Baliga on 10/09/23.
//

import Foundation

class LocalFavouritePostService: FavouritePostService {

    let store: UserPostStore

    init(store: UserPostStore) {
        self.store = store
    }

    func favouriteUserPost(post: UserPost, completion: @escaping (Error?) -> Void) {

        store.insert(post: post.toLocal()) { error in
            completion(error)
        }
    }
    
    func unfavouriteUserPost(post: UserPost, completion: @escaping (Error?) -> Void) {
        store.delete(post: post.toLocal()) { error in
            completion(error)
        }
    }
    
    func getAllFavouritePosts(completion: @escaping (FavouritePostResult) -> Void) {
        store.retrieveFavouritePosts { result in
            switch result {
            case .empty: completion(.success([]))
            case .found(let posts): completion(.success(posts.toModels()))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}

private extension UserPost {

    func toLocal() -> LocalUserPost {
        return LocalUserPost(userId: self.userId, id: self.id, title: self.title, body: self.body)
    }
}

private extension Array where Element == LocalUserPost {

    func toModels() -> [UserPost] {
        return map {
            UserPost(userId: $0.userId, id: $0.id, title: $0.title, body: $0.body)
        }
    }
}
