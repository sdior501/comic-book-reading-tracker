import Foundation

struct Issue {
    
    var volume: Int!
    var issueNumber: String!
    
    init(_ volume: Int, _ issueNumber: String) {
        self.volume = volume
        self.issueNumber = issueNumber
    }
}
