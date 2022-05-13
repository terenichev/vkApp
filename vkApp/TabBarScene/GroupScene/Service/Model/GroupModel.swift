//
//  GroupModel.swift
//  vkApp
//
//  Created by Денис Тереничев on 11.05.2022.
//

import Foundation
import RealmSwift

struct SearchGroup: Codable {
    let response: ResponseGroup
}

class ResponseGroup: Codable {
    var count: Int = 0
    var items: [Group] = []
}

class Group: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo50: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo50 = "photo_50"
    }
}

struct JoinOrLeaveGroupModel: Decodable {
    var response: Int
}
