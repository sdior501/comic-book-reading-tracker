import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class ReadingListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var comicArray: [Comic] = []
    var readingList: [Issue] = [Issue(7257, "1"), Issue(7257, "2"), Issue(7257, "3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationBar()
        prepareTableView()
        prepareComicData()
    }
    
    fileprivate func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "IssueTableViewCell", bundle: nil), forCellReuseIdentifier: "IssueTableViewCell")
    }
    
    fileprivate func prepareComicData() {
        for issueResponse in readingList {
            Alamofire.request("https://comicvine.gamespot.com/api/issues/?api_key=7278e772d67dbbba0b45c2db611f469b2786000d&field_list=name,image,description,id,issue_number&filter=volume:\(issueResponse.volume),issue_number:\(issueResponse.issueNumber)&format=json").responseObject { (response: DataResponse<SearchResponse>) in
                if let searchResponse = response.result.value {
                    guard let comic = searchResponse.comic?[0] else {
                        return
                    }
                    self.prepareComicCover(of: comic)
                    self.comicArray.append(comic)
                }
                self.tableView.reloadData()
            }
        }
        
//        for volumeResponse in readingList {
//            Alamofire.request("https://comicvine.gamespot.com/api/volumes/?api_key=7278e772d67dbbba0b45c2db611f469b2786000d&field_list=name,id,count_of_issues,start_year&filter=id:\(issue.volume)&format=json").responseObject { (response: DataResponse<SearchResponse>) in
//                if let searchResponse = response.result.value {
//                    guard let comic = searchResponse.comic?[0] else {
//                        return
//                    }
//                    self.comicArray.append(comic)
//                }
//                self.tableView.reloadData()
//            }
//        }

    }

    fileprivate func prepareComicCover(of comic: Comic) {
        if comic.cover == nil {
            self.tableView.reloadData()
            guard let url = comic.cover!.coverUrl else {
                return
            }
            Alamofire.request(url).responseImage { response in
                if let cover = response.result.value {
                    comic.coverImage = cover
                }
            }
        }
    }

    fileprivate func prepareNavigationBar() {
        navigationItem.title = "Reading List"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .blackTranslucent
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

        cell.readingNumberLabel.text = "\(indexPath.row + 1)"
        cell.issueNameLabel.text = comicAtIndex.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicArray.count
    }
}
