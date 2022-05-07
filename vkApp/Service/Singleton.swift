//
//  Singleton.swift
//  vkApp
//
//  Created by Денис Тереничев on 13.04.2022.
//

import Foundation

class Singleton {

    static let instance = Singleton()

    private init() {}

    var id: Int?
    var token: String?
    var friends: [FriendsItem]?
}
