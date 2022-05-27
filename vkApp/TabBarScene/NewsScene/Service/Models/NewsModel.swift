//
//  NewsModel.swift
//  vkApp
//
//  Created by Денис Тереничев on 27.05.2022.
//

import Foundation

// MARK: - Response
struct NewsResponse: Codable {
    let response: ResponseClass?
}

// MARK: - ResponseClass
struct ResponseClass: Codable {
    let items: [NewsItem?]
    let profiles: [Profile?]
    let groups: [NewsGroup?]
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case profiles = "profiles"
        case groups = "groups"
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct NewsGroup: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type = "type"
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - Item
struct NewsItem: Codable {
    let sourceID, date: Int?
    let canDoubtCategory, canSetCategory: Bool?
    let isFavorite: Bool?
    let postType: String?
    let text: String?
    let markedAsAds: Int?
    let attachments: [Attachment]
    let postSource: PostSource?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    let donut: Donut?
    let shortTextRate: Double?
    let carouselOffset: Int?
    let postID: Int?
    let type: String?
    let copyHistory: [CopyHistory]?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date = "date"
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case postType = "post_type"
        case text = "text"
        case markedAsAds = "marked_as_ads"
        case attachments = "attachments"
        case postSource = "post_source"
        case comments = "comments"
        case likes = "likes"
        case reposts = "reposts"
        case views = "views"
        case donut = "donut"
        case shortTextRate = "short_text_rate"
        case carouselOffset = "carousel_offset"
        case postID = "post_id"
        case type = "type"
        case copyHistory = "copy_history"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: TypeEnum?
    let photo: NewsPhoto?
}

// MARK: - Photo
struct NewsPhoto: Codable {
    let albumID, date, id, ownerID: Int?
    let accessKey: String?
    let sizes: [NewsPhotoSize]
    let text: String?
    let userID: Int?
    let hasTags: Bool?
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date = "date"
        case id = "id"
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case sizes = "sizes"
        case text = "text"
        case userID = "user_id"
        case hasTags = "has_tags"
        case postID = "post_id"
    }
}

// MARK: - Size
struct NewsPhotoSize: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}

enum TypeEnum: String, Codable {
    case photo = "photo"
}

// MARK: - Comments
struct Comments: Codable {
    let canPost, count: Int?
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count = "count"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let id, ownerID, fromID, date: Int?
    let postType, text: String?
    let attachments: [Attachment]
    let postSource: PostSource?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ownerID = "owner_id"
        case fromID = "from_id"
        case date = "date"
        case postType = "post_type"
        case text = "text"
        case attachments = "attachments"
        case postSource = "post_source"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String?
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, count, userLikes, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count = "count"
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int?
}

// MARK: - Profile
struct Profile: Codable {
    let id, sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let onlineInfo: OnlineInfo?
    let online: Int?
    let firstName, lastName: String?
    let canAccessClosed, isClosed: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sex = "sex"
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online = "online"
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible: Bool?
    let lastSeen: Int?
    let isOnline: Bool?
    let appID: Int?
    let isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible = "visible"
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case appID = "app_id"
        case isMobile = "is_mobile"
    }
}
