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
    var groups: [NewsGroup]
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - NewsGroup
struct NewsGroup: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: GroupType?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

enum GroupType: String, Codable {
    case group = "group"
    case page = "page"
}

// MARK: - NewsItem
struct NewsItem: Codable {
    let sourceID: Int
    let date: Double
    let canDoubtCategory, canSetCategory, isFavorite: Bool?
    let postType: PostTypeEnum?
    let text: String?
    let copyHistory: [CopyHistory]?
    let postSource: ItemPostSource?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let donut: Donut?
    let shortTextRate: Double?
    let postID: Int?
    let type: PostTypeEnum?
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
    
    var attachmentsTypes: [AttachmentType.RawValue] {
        get {
            let attachmentsTypes = attachments?.compactMap{ $0.type?.rawValue }
            return attachmentsTypes ?? []
        }
    }
    
    var isTextShowMore: Bool = false
    
    let carouselOffset, topicID: Int?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case postType = "post_type"
        case text
        case copyHistory = "copy_history"
        case postSource = "post_source"
        case comments, likes, reposts, donut
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case type, views, attachments
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
    let type: AttachmentType?
    let video: PurpleVideo?
    let photo: AttachmentPhoto?
    let audio: Audio?
    let link: Link?
}

// MARK: - Audio
struct Audio: Codable {
    let artist: String?
    let id, ownerID: Int?
    let title: String?
    let duration: Int?
    let isExplicit, isFocusTrack: Bool?
    let trackCode: String?
    let url: String?
    let date: Int?
    let mainArtists: [MainArtist]?
    let shortVideosAllowed, storiesAllowed, storiesCoverAllowed: Bool?
    let albumID: Int?

    enum CodingKeys: String, CodingKey {
        case artist, id
        case ownerID = "owner_id"
        case title, duration
        case isExplicit = "is_explicit"
        case isFocusTrack = "is_focus_track"
        case trackCode = "track_code"
        case url, date
        case mainArtists = "main_artists"
        case shortVideosAllowed = "short_videos_allowed"
        case storiesAllowed = "stories_allowed"
        case storiesCoverAllowed = "stories_cover_allowed"
        case albumID = "album_id"
    }
}

// MARK: - MainArtist
struct MainArtist: Codable {
    let name, domain, id: String?
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let title, linkDescription, target: String?
    let isFavorite: Bool?
    let photo: LinkPhoto?

    enum CodingKeys: String, CodingKey {
        case url, title
        case linkDescription = "description"
        case target
        case isFavorite = "is_favorite"
        case photo
    }
}

// MARK: - LinkPhoto
struct LinkPhoto: Codable {
    let albumID, date, id, ownerID: Int?
    let sizes: [PhotoSize]?
    let text: String?
    let userID: Int?
    let hasTags: Bool?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
    }
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

enum AttachmentType: String, Codable {
    case audio = "audio"
    case link = "link"
    case photo = "photo"
    case video = "video"
}

// MARK: - PurpleVideo
struct PurpleVideo: Codable {
    let canComment, canLike, canRepost, canSubscribe: Int?
    let canAddToFaves, canAdd, comments, date: Int?
    let videoDescription: String?
    let duration: Int?
    let image, firstFrame: [PhotoSize]?
    let width, height, id, ownerID: Int?
    let title: String?
    let isFavorite: Bool?
    let trackCode: String?
    let videoRepeat: Int?
    let type: String?
    let views: Int?
    let accessKey: String?

    enum CodingKeys: String, CodingKey {
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case videoRepeat = "repeat"
        case type, views
        case accessKey = "access_key"
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

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let id, ownerID, fromID, date: Int?
    let postType: PostTypeEnum?
    let text: String?
    let attachments: [CopyHistoryAttachment]?
    let postSource: CopyHistoryPostSource?
    let signerID: Int?
    let isDeleted: Bool?
    let deletedReason, deletedDetails: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case fromID = "from_id"
        case date
        case postType = "post_type"
        case text, attachments
        case postSource = "post_source"
        case signerID = "signer_id"
        case isDeleted = "is_deleted"
        case deletedReason = "deleted_reason"
        case deletedDetails = "deleted_details"
    }
}

// MARK: - CopyHistoryAttachment
struct CopyHistoryAttachment: Codable {
    let type: AttachmentType?
    let photo: AttachmentPhoto?
    let video: FluffyVideo?
    let link: Link?
    let audio: Audio?
}

// MARK: - FluffyVideo
struct FluffyVideo: Codable {
    let accessKey: String?
    let canComment, canLike, canRepost, canSubscribe: Int?
    let canAddToFaves, canAdd, comments, date: Int?
    let videoDescription: String?
    let duration: Int?
    let image, firstFrame: [PhotoSize]?
    let width, height, id, ownerID: Int?
    let title: String?
    let isFavorite: Bool?
    let trackCode, type: String?
    let views, userID, isSubscribed, contentRestricted: Int?
    let contentRestrictedMessage: String?
    let isExplicit: Int?
    let mainArtists: [MainArtist]?
    let releaseDate: Int?
    let genres: [Genre]?
    let videoRepeat: Int?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type, views
        case userID = "user_id"
        case isSubscribed = "is_subscribed"
        case contentRestricted = "content_restricted"
        case contentRestrictedMessage = "content_restricted_message"
        case isExplicit = "is_explicit"
        case mainArtists = "main_artists"
        case releaseDate = "release_date"
        case genres
        case videoRepeat = "repeat"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - CopyHistoryPostSource
struct CopyHistoryPostSource: Codable {
    let platform: Platform?
    let type: PostSourceType?
}

enum Platform: String, Codable {
    case android = "android"
    case iphone = "iphone"
}

enum PostSourceType: String, Codable {
    case api = "api"
    case mvk = "mvk"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case photo = "photo"
    case post = "post"
    case video = "video"
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
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - ItemPostSource
struct ItemPostSource: Codable {
    let platform: Platform?
    let type: PostSourceType?
    let data: String?
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
