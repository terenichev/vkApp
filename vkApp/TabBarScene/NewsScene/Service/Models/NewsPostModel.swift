//
//  NewsModel.swift
//  vkApp
//
//  Created by Денис Тереничев on 27.05.2022.
//

import UIKit

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let response: ResponseClass
}

// MARK: - ResponseClass
struct ResponseClass: Codable {
    var items: [NewsItem]
    var profiles: [NewsProfile]
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - NewsItem
struct NewsItem: Codable {
    let sourceID: Int
    let date: Double
    let canDoubtCategory, canSetCategory, isFavorite: Bool?
    let text: String?
    var isTextShowMore: Bool = false
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let shortTextRate: Double?
    let postID: Int?
    let views: Views?
    let attachments: [ItemAttachment]?
    var photosURL: [String]? {
        get {
            let photosURL = attachments?.compactMap{ $0.photo?.sizes?.last?.url }
            return photosURL
        }
    }
    
    var aspectRatio: CGFloat {
        get {
            let aspectRatio = attachments?.compactMap{ $0.photo?.sizes?.last?.aspectRatio }.last
            return aspectRatio ?? 1
        }
    }
    
    let carouselOffset, topicID: Int?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case text
        case comments, likes, reposts
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case views, attachments
        case carouselOffset = "carousel_offset"
        case topicID = "topic_id"
    }
    func getStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy в HH:mm"
        let postDate = Date(timeIntervalSince1970: date)
        
        return dateFormatter.string(from: postDate)
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
    let type: String?
    let width, withPadding: Int?
    
    var aspectRatio: CGFloat {
        return CGFloat(height ?? 1)/CGFloat(width ?? 1)
    }

    enum CodingKeys: String, CodingKey {
        case height, url, type, width
        case withPadding = "with_padding"
    }
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
    let id, sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let onlineInfo: OnlineInfo?
    let online: Int?
    let firstName, lastName: String?
    let canAccessClosed, isClosed: Bool?
    let deactivated: String?
    let onlineMobile, onlineApp: Int?

    enum CodingKeys: String, CodingKey {
        case id, sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case deactivated
        case onlineMobile = "online_mobile"
        case onlineApp = "online_app"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible: Bool?
    let lastSeen: Int?
    let isOnline, isMobile: Bool?
    let appID: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case appID = "app_id"
    }
}
