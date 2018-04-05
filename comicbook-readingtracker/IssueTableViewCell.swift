import UIKit
import M13Checkbox

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var readingNumberLabel: UILabel!
    @IBOutlet weak var volumeNameLabel: UILabel!
    @IBOutlet weak var issueNameLabel: UILabel!
    @IBOutlet weak var checkBox: M13Checkbox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCoverView()
        prepareCheckBox()
    }
    
    fileprivate func prepareCheckBox() {
        checkBox.boxType = .circle
        checkBox.stateChangeAnimation = .spiral
        checkBox.animationDuration = 0.5
    }
    
    fileprivate func prepareCoverView() {
        coverView.contentMode = .scaleAspectFit
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

