import UIKit
import ObjectMapper
import AlamofireObjectMapper

class ComicSearchResponse: Mappable {
    
    var comic: [Comic]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        comic <- map["results"]
    }
}

class VolumeSearchResponse: Mappable {
    
    var volume: [Volume]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        volume <- map["results"]
    }
}

class Comic: Mappable {
    
    var description: String?
    var id: Int?
    var cover: Cover?
    var issueNumber: String?
    var name: String?
    var coverImage: UIImage?
    var volume: Volume?
    var order: Int!
    var read = false
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        description <- map["description"]
        id <- map["id"]
        cover <- map["image"]
        issueNumber <- map["issue_number"]
        name <- map["name"]
    }
}

class Cover: Mappable {
    
    var coverUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        coverUrl <- map["original_url"]
    }
}

class Volume: Mappable {
    
    var totalIssues: Int?
    var id: Int?
    var nameVolume: String?
    var year: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        totalIssues <- map["count_of_issues"]
        id <- map["id"]
        nameVolume <- map["name"]
        year <- map["start_year"]
    }
}
