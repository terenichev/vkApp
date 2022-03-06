//
//  Post.swift
//  vkApp
//
//  Created by Денис Тереничев on 06.03.2022.
//

import Foundation
import UIKit

struct Post {
    
    let friend: Friend
    let dateOfPost: String
    let textInPost: String?
    let likesCount: Int
    let commentsCount: Int
    let sharesCount: Int
}
