//
//  UsersIdsArray.swift
//  vkApp
//
//  Created by Денис Тереничев on 16.04.2022.
//

import Foundation


struct UsersIdsArray: Codable {
    let response: FriendsList
}

struct FriendsList: Codable {
    
    let count: Int
    let ids: [Int]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case ids = "items"
    }
}
