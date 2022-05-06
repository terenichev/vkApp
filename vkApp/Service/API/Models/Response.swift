//
//  User.swift
//  vkApp
//
//  Created by Денис Тереничев on 05.05.2022.
//

import Foundation

// MARK: - User
enum DTO {
    
    struct Response: Codable {
        let response: [User]
    }
    
    // MARK: - Response
    struct User: Codable {
        let id: Int
        let firstName, lastName: String
        let photoMaxOrig: String
        let status: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case photoMaxOrig = "photo_max_orig"
            case status
        }
    }
}
