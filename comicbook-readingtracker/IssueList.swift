import UIKit

enum IssueType {
    case UltimateSpiderMan
    case UltimateXMen
}

struct IssueList {
    
    var issueType: IssueType!
    var name: String!
    var logo: UIImage!
    
    init(issueType: IssueType, name: String, logo: UIImage) {
        self.issueType = issueType
        self.name = name
        self.logo = logo
    }
}
