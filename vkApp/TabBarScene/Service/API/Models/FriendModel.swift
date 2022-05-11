//
//  UsersIdsArray.swift
//  vkApp
//
//  Created by Денис Тереничев on 16.04.2022.
//

import Foundation
import RealmSwift
import UIKit

struct FriendModel: Codable {
    let response: FriendsList
}

class FriendsList: Codable {
    var count: Int = 0
    var items: [FriendsItem] = []
}

class FriendsItem: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var status: String? = ""
    @objc dynamic var avatarUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case status = "status"
        case avatarUrl = "photo_50"
    }
}