//
//  User.swift
//  vkApp
//
//  Created by Денис Тереничев on 20.05.2022.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let response: [UsersInfo]
}

// MARK: - ResponseElement
struct UsersInfo: Codable {
    let online: Int

    enum CodingKeys: String, CodingKey {
        case online = "online"
    }
}
