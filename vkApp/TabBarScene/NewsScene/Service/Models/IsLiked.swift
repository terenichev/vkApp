//
//  IsLiked.swift
//  vkApp
//
//  Created by Денис Тереничев on 01.07.2022.
//

import Foundation

// MARK: - IsLiked
struct IsLiked: Codable {
    let response: IsLikedResponse
}

// MARK: - Response
struct IsLikedResponse: Codable {
    let liked, copied: Int
}
