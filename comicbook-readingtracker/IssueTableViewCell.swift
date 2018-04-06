import UIKit
import M13Checkbox

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var readingNumberLabel: UILabel!
    @IBOutlet weak var volumeNameLabel: UILabel!
    @IBOutlet weak var issueNameLabel: UILabel!
    @IBOutlet weak var checkBox: M13Checkbox!
    
    var comic: Comic!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCoverView()
        prepareCheckBox()
    }
    
    fileprivate func prepareCheckBox() {
        checkBox.boxType = .circle
        checkBox.stateChangeAnimation = .spiral
        checkBox.animationDuration = 0.5
        checkBox.addTarget(self, action: #selector(checkBoxClicked), for: .valueChanged)
    }
    
    fileprivate func prepareCoverView() {
        coverView.contentMode = .scaleAspectFit
    }
    
    @objc func checkBoxClicked() {
        
        switch checkBox.checkState {
            
        case .checked:
            
            if let id = comic.id {
                User.readComics.append(id)
            }
            
        case .unchecked:
            if let id = comic.id {
                User.readComics.remove(at: User.readComics.index(of: id)! )
            }
            
        default:
            break
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

