//
//  FeedListModel.swift
//  HackathonProject
//
//  Created by Swati Yadav on 17/08/21.
//

struct FeedListModel: Codable {
    let data: DataResponse?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(DataResponse.self, forKey: .data)
    }
}

struct DataResponse: Codable {
    var after: String?
    let children: [ChildrenData]?
    
    enum CodingKeys: String, CodingKey {
        case after, children
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        after = try values.decodeIfPresent(String.self, forKey: .after)
        children = try values.decodeIfPresent([ChildrenData].self, forKey: .children)
    }
}

struct ChildrenData: Codable {
    let dataValue: DataValue?
    
    enum CodingKeys: String, CodingKey {
        case dataValue = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dataValue = try values.decodeIfPresent(DataValue.self, forKey: .dataValue)
    }
}
    
struct DataValue: Codable {
    let title: String?
    let score: Int?
    let numOfComments: Int?
    let thumbnail: String?
    let thumbnailWidth: Int?
    let thumbnailHeight: Int?
    
    enum CodingKeys: String, CodingKey {
        case title, score
        case numOfComments = "num_comments"
        case thumbnail = "thumbnail"
        case thumbnailWidth = "thumbnail_width"
        case thumbnailHeight = "thumbnail_height"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        numOfComments = try values.decodeIfPresent(Int.self, forKey: .numOfComments)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        thumbnailWidth = try values.decodeIfPresent(Int.self, forKey: .thumbnailWidth)
        thumbnailHeight = try values.decodeIfPresent(Int.self, forKey: .thumbnailHeight)
    }
}
