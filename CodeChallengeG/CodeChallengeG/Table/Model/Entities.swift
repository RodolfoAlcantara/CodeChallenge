//
//  Entities.swift
//  CodeChallengeG
//
//  Created by Rodolfo Alcantara on 1/30/19.
//  Copyright © 2019 rodolfo. All rights reserved.
//

import Foundation

/**
 Entidad pública para definición de usuario
 */
public struct RequestImage {
    public var page: Int
    public var nameToSearch: String
    public init (page: Int, nameToSearch: String) {
        self.page = page
        self.nameToSearch = nameToSearch
    }
}

import Foundation

struct ImageDataResponse: Codable {
    let data: [Datum]
    let success: Bool
    let status: Int
}

struct Datum: Codable {
    let id: String?
    let title, description: String?
    let datetime: Int?
    let cover: String?
    let coverWidth, coverHeight: Int?
    let accountURL: String?
    let accountID: Int?
    let privacy: String?
    let layout: String?
    let views: Int?
    let link: String?
    let ups, downs, points, score: Int?
    let isAlbum: Bool?
    let vote: JSONNull?
    let favorite: Bool?
    let nsfw: Bool?
    let section: String?
    let commentCount, favoriteCount: Int?
    let topic: String?
    let topicID, imagesCount: Int?
    let inGallery, isAd: Bool?
    let tags: [Tag]?
    let adType: Int?
    let adURL: String?
    let inMostViral: Bool?
    let includeAlbumAds: Bool?
    let images: [Datum]?
    let type: TypeEnum?
    let animated: Bool?
    let width, height, size, bandwidth: Int?
    let hasSound: Bool?
    let mp4: String?
    let gifv: String?
    let hls: String?
    let mp4Size: Int?
    let looping: Bool?
    let processing: Processing?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, datetime, cover
        case coverWidth = "cover_width"
        case coverHeight = "cover_height"
        case accountURL = "account_url"
        case accountID = "account_id"
        case privacy, layout, views, link, ups, downs, points, score
        case isAlbum = "is_album"
        case vote, favorite, nsfw, section
        case commentCount = "comment_count"
        case favoriteCount = "favorite_count"
        case topic
        case topicID = "topic_id"
        case imagesCount = "images_count"
        case inGallery = "in_gallery"
        case isAd = "is_ad"
        case tags
        case adType = "ad_type"
        case adURL = "ad_url"
        case inMostViral = "in_most_viral"
        case includeAlbumAds = "include_album_ads"
        case images, type, animated, width, height, size, bandwidth
        case hasSound = "has_sound"
        case mp4, gifv, hls
        case mp4Size = "mp4_size"
        case looping, processing
    }
}

enum Layout: String, Codable {
    case blog = "blog"
}

enum Privacy: String, Codable {
    case hidden = "hidden"
    case privacyPublic = "public"
}

struct Processing: Codable {
    let status: Status?
}

enum Status: String, Codable {
    case completed = "completed"
}

enum Section: String, Codable {
    case aww = "aww"
    case empty = ""
}

struct Tag: Codable {
    let name, displayName: String?
    let followers, totalItems: Int?
    let following: Bool?
    let backgroundHash: String?
    let thumbnailHash, accent: String?
    let backgroundIsAnimated, thumbnailIsAnimated, isPromoted: Bool?
    let description: String?
    let logoHash, logoDestinationURL: JSONNull?
    let descriptionAnnotations: DescriptionAnnotations?
    
    enum CodingKeys: String, CodingKey {
        case name
        case displayName = "display_name"
        case followers
        case totalItems = "total_items"
        case following
        case backgroundHash = "background_hash"
        case thumbnailHash = "thumbnail_hash"
        case accent
        case backgroundIsAnimated = "background_is_animated"
        case thumbnailIsAnimated = "thumbnail_is_animated"
        case isPromoted = "is_promoted"
        case description
        case logoHash = "logo_hash"
        case logoDestinationURL = "logo_destination_url"
        case descriptionAnnotations = "description_annotations"
    }
}

struct DescriptionAnnotations: Codable {
}

enum Topic: String, Codable {
    case noTopic = "No Topic"
}

enum TypeEnum: String, Codable {
    case imageGIF = "image/gif"
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
    case videoMp4 = "video/mp4"
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
