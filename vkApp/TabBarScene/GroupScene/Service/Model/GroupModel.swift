//
//  GroupModel.swift
//  vkApp
//
//  Created by Денис Тереничев on 11.05.2022.
//

import Foundation
//import RealmSwift

struct SearchGroup: Codable {
    let response: ResponseGroup
}

class ResponseGroup: Codable {
    var count: Int = 0
    var items: [Group] = []
}

class Group: Codable {
    var id: Int = 0
    var name: String = ""
    var photo100: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo100 = "photo_100"
    }
}

struct JoinOrLeaveGroupModel: Decodable {
    var response: Int
}
