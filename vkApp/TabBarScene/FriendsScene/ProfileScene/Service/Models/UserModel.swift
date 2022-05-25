//
//  UserModel.swift
//  vkApp
//
//  Created by Денис Тереничев on 25.05.2022.
//

import Foundation

// MARK: - Response
struct UserResponse: Decodable {
    let response: [User]
}

// MARK: - ResponseElement
struct User: Decodable {
    let id: Int
    let photo200_Orig: String
    let hasMobile, isFriend: Int
    let about: String?
    let status: String
    let lastSeen: LastSeen
    let followersCount, online: Int?
    let firstName, lastName: String
    let canAccessClosed, isClosed: Bool

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case photo200_Orig = "photo_200_orig"
        case hasMobile = "has_mobile"
        case isFriend = "is_friend"
        case about = "about"
        case status = "status"
        case lastSeen = "last_seen"
        case followersCount = "followers_count"
        case online = "online"
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

// MARK: - LastSeen
struct LastSeen: Decodable {
    let platform, time: Int
}
