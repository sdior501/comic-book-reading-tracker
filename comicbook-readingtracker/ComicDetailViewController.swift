import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class ComicDetailViewController: UIViewController {
    
    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var comic: Comic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareLabels()
        prepareBlur()
        prepareComicDetails()
        prepareCoverView()
    }
    
    fileprivate func prepareBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.75
        blurEffectView.frame = stackView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.addSubview(blurEffectView)
        stackView.sendSubview(toBack: blurEffectView)
    }
    
    fileprivate func prepareCoverView() {
        coverView.image = comic.coverImage
        coverView.contentMode = .scaleAspectFill
        coverView.clipsToBounds = true
    }
    
    fileprivate func prepareComicDetails() {
        nameLabel.text = comic.name
        issueNumberLabel.text = "Issue: \(comic.issueNumber!)"
        descriptionLabel.text = comic.description
    }
    
    fileprivate func prepareLabels() {
        nameLabel.textColor = .white
        issueNumberLabel.textColor = .white
        descriptionLabel.textColor = .white
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        issueNumberLabel.font = UIFont.italicSystemFont(ofSize: 20)
        
        nameLabel.text = ""
        issueNumberLabel.text = ""
        descriptionLabel.text = ""
    }
}

