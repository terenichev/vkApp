//
//  GroupModel.swift
//  vkApp
//
//  Created by Денис Тереничев on 11.05.2022.
//

import Foundation
import RealmSwift

struct SearchGroup: Decodable {
    let response: ResponseGroup
}

struct ResponseGroup: Decodable {
    let count: Int
    let items: [Group]
}

class Group: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var isMember: Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case isMember = "is_member"
        case photo100 = "photo_100"
    }

    override class func primaryKey() -> String? {
        "id"
    }
}
