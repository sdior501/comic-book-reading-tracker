import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class ReadingListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var comicArray: [Comic] = []
    var readingList: [Issue] = []
    var issueType: IssueType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareReadingList()
        prepareTableView()
    }
    
    fileprivate func sortComicList() {
        self.comicArray = self.comicArray.sorted(by: { $0.order < $1.order })
    }
    
    fileprivate func prepareReadingList() {
        var fileName = ""
        switch issueType {
        case .UltimateSpiderMan:
            fileName = "Ultimate Spider-Man"
        case .UltimateXMen:
            fileName = "Ultimate X-Men"
        case .Spawn:
            fileName = "Spawn"
        default:
            break
        }
        let url = Bundle.main.url(forResource: fileName, withExtension:"json")
        guard let stringURL = url?.absoluteString else { return }
        Alamofire.request(stringURL).responseArray { (response: DataResponse<[Issue]>) in
            if let issueArray = response.result.value {
                self.readingList = issueArray
                self.prepareComicData()
            }
        }
    }
    
    fileprivate func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "IssueTableViewCell", bundle: nil), forCellReuseIdentifier: "IssueTableViewCell")
    }
    
    fileprivate func prepareComicData() {
        for issue in readingList {
            let issueRequest = "https://comicvine.gamespot.com/api/issues/?api_key=7278e772d67dbbba0b45c2db611f469b2786000d&field_list=name,image,description,id,issue_number&filter=volume:\(issue.volume!),issue_number:\(issue.issueNumber!)&format=json"
            let volumeRequest = "https://comicvine.gamespot.com/api/volumes/?api_key=7278e772d67dbbba0b45c2db611f469b2786000d&field_list=name,id,count_of_issues,start_year&filter=id:\(issue.volume!)&format=json"
            
            let safeIssueRequest = issueRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

            Alamofire.request(safeIssueRequest).responseObject { (response: DataResponse<ComicSearchResponse>) in
                if let searchResponse = response.result.value {
                    guard let comic = searchResponse.comic?[0] else {
                        return
                    }
                    self.prepareComicCover(of: comic)
                    self.comicArray.append(comic)
                    comic.order = issue.order
                    self.sortComicList()
                    self.tableView.reloadData()
                    
                    Alamofire.request(volumeRequest).responseObject { (response: DataResponse<VolumeSearchResponse>) in
                        if let searchResponse = response.result.value {
                            guard let volume = searchResponse.volume?[0] else {
                                return
                            }
                            comic.volume = volume
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }

    fileprivate func prepareComicCover(of comic: Comic) {
        if comic.coverImage == nil {
            self.tableView.reloadData()
            guard let url = comic.cover!.coverUrl else {
                return
            }
            Alamofire.request(url).responseImage { response in
                if let cover = response.result.value {
                    comic.coverImage = cover
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func showDetails(ofComicsAt index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let comicDetailVC = storyboard.instantiateViewController(withIdentifier: "ComicDetailViewController") as! ComicDetailViewController
        comicDetailVC.comic = comicArray[index]
        navigationController?.pushViewController(comicDetailVC, animated: true)
    }
}

extension ReadingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        showDetails(ofComicsAt: selectedIndex)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: IssueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell") as? IssueTableViewCell else {
            return UITableViewCell()
        }
        
        let comicAtIndex = comicArray[indexPath.row]
        
        cell.readingNumberLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cell.volumeNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cell.issueNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        cell.coverView.image = comicAtIndex.coverImage
        cell.readingNumberLabel.text = "#\(indexPath.row + 1) / \(readingList.count)"
        cell.volumeNameLabel.text = "\(comicAtIndex.volume?.nameVolume ?? "") (\(comicAtIndex.volume?.year ?? ""))"
        cell.issueNameLabel.text = "\(comicAtIndex.issueNumber ?? "") / \(comicAtIndex.volume?.totalIssues.map(String.init) ?? "")\n\(comicAtIndex.name ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicArray.count
    }
}
