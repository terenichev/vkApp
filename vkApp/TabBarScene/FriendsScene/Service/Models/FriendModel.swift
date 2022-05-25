//
//  UsersIdsArray.swift
//  vkApp
//
//  Created by Денис Тереничев on 16.04.2022.
//

import UIKit

struct FriendModel: Codable {
    let response: FriendsList
}

class FriendsList: Codable {
    var count: Int = 0
    var items: [FriendsItem] = []
}

class FriendsItem: Codable {
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var status: String? = ""
    var avatarMiddleSizeUrl: String = ""
    var isOnline: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case status = "status"
        case isOnline = "online"
        case avatarMiddleSizeUrl = "photo_100"
    }
}
