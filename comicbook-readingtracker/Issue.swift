import UIKit
import ObjectMapper
import AlamofireObjectMapper

class Issue: Mappable {
    
    var volume: String!
    var issueNumber: String!
    var order: Int!
    
    init(_ volume: String, _ issueNumber: String, _ order: Int) {
        self.volume = volume
        self.issueNumber = issueNumber
        self.order = order
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        volume <- map["volume"]
        issueNumber <- map["issue_number"]
        order <- map["order"]
    }
}
