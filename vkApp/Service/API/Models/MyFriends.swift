//
//  UsersIdsArray.swift
//  vkApp
//
//  Created by Денис Тереничев on 16.04.2022.
//

import Foundation
import RealmSwift
import UIKit

struct MyFriends: Codable {
    let response: FriendsList
}

class FriendsList: Codable {
    var count: Int = 0
    var items: [FriendsItem?] = []
}

class FriendsItem: Object, Codable {
    @objc dynamic var id: Int32 = 22178345
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var status: String? = ""
    @objc dynamic var avatarUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarUrl = "photo_200_orig"
    }
}
