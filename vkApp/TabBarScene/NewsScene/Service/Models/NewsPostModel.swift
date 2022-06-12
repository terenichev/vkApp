//
//  NewsModel.swift
//  vkApp
//
//  Created by Денис Тереничев on 27.05.2022.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let response: ResponseClass
}

// MARK: - ResponseClass
struct ResponseClass: Codable {
    var items: [NewsItem]
    let profiles: [NewsProfile]
    let groups: [NewsGroup]
}

// MARK: - NewsGroup
struct NewsGroup: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let isMember: Int?
    let photo50, photo100: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case isMember = "is_member"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
    }
}

// MARK: - NewsItem
struct NewsItem: Codable {
    let sourceID, date: Int?
    let text: String?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let shortTextRate: Double?
    let postID: Int?
    let views: Views?
    let attachments: [ItemAttachment]?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case comments, likes, reposts
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case views, attachments
    }
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    let photo: AttachmentPhoto?
}

// MARK: - PhotoSize
struct PhotoSize: Codable {
    let height: Int?
    let url: String?
    let type: SizeType?
    let width, withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height, url, type, width
        case withPadding = "with_padding"
    }
}

enum SizeType: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

// MARK: - AttachmentPhoto
struct AttachmentPhoto: Codable {
    let albumID, date, id, ownerID: Int?
    let postID: Int?
    let sizes: [PhotoSize]?
    let text: String?
    let hasTags: Bool?
    let accessKey: String?
    let lat, long: Double?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case postID = "post_id"
        case sizes, text
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case lat, long
        case userID = "user_id"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let canPost, count: Int?
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
    }
}


// MARK: - Likes
struct Likes: Codable {
    let canLike, count, userLikes, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int?
}

// MARK: - NewsProfile
struct NewsProfile: Codable {
    let id: Int?
    let photo50, photo100: String?
    let onlineInfo: OnlineInfo?
    let firstName, lastName: String?
    let canAccessClosed, isClosed: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let isOnline, isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
