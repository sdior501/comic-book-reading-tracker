import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var readingNumberLabel: UILabel!
    @IBOutlet weak var volumeNameLabel: UILabel!
    @IBOutlet weak var issueNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCoverView()
    }
    
    fileprivate func prepareCoverView() {
        coverView.contentMode = .scaleAspectFit
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

