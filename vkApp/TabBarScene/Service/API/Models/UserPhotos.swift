//
//  UserPhotos.swift
//  vkApp
//
//  Created by Денис Тереничев on 16.04.2022.
//

import Foundation

// MARK: - UserPhotoURLResponse
struct UserPhotoURLResponse: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

// MARK: - Size
struct Size: Codable {
    let url: String
}

    
    

    





