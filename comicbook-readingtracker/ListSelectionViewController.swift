import UIKit

class ListSelectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var readingLists: [IssueList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareIssueList()
        prepareTableView()
        prepareNavigationBar()
    }
    
    fileprivate func prepareIssueList() {
        let ultimateSpiderMan = IssueList(issueType: IssueType.UltimateSpiderMan, name: "Ultimate Spider-Man", logo: UIImage(named:"spidey_logo")!)
        let ultimateXMen = IssueList(issueType: IssueType.UltimateXMen, name: "Ultimate X-Men", logo: UIImage(named:"xmen_logo")!)
        readingLists = [ultimateSpiderMan, ultimateXMen]
    }
    
    fileprivate func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "IssueTableViewCell", bundle: nil), forCellReuseIdentifier: "IssueTableViewCell")
    }
    fileprivate func prepareNavigationBar() {
        navigationItem.title = "Comic Book Reading Order"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    func showDetails(ofReadingListAt index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readingListsVC = storyboard.instantiateViewController(withIdentifier: "ReadingListViewController") as! ReadingListViewController
        readingListsVC.issueType = readingLists[index].issueType
        navigationController?.pushViewController(readingListsVC, animated: true)
    }

}
extension ListSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        showDetails(ofReadingListAt: selectedIndex)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: IssueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell") as? IssueTableViewCell else {
            return UITableViewCell()
        }
        
       let listAtIndex = readingLists[indexPath.row]
   
        cell.readingNumberLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cell.volumeNameLabel.font = UIFont.italicSystemFont(ofSize: 20)
        cell.issueNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.coverView.image = listAtIndex.logo
        cell.readingNumberLabel.text = ""
        cell.volumeNameLabel.text = ""
        cell.issueNameLabel.text = listAtIndex.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingLists.count
    }
}
