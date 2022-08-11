import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var scoreManager = ScoreManager()
    var fromDate = ""
    var toDate = ""
    var groupedMatches: [[ScoreModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreManager.delegate = self
        scoreManager.fetchScore(fromDate: fromDate, toDate: toDate)
        setupView()
    }
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.matchCellNibName, bundle: nil), forCellReuseIdentifier: K.matchCellIdentifier)
    }
}
//MARK: - ScoreManagerDelegate
extension ResultViewController: ScoreManagerDelegate {
    func didUpdateScore(scores: [ScoreModel]) {
        var matches: [ScoreModel] = scores
        var groupedDictionary: [String: [ScoreModel]]?
        matches.sort { $0.leagueName < $1.leagueName }
        groupedDictionary = Dictionary(grouping: matches) { (league) -> String in
            return league.leagueName
        }
        if let groupedDictionary = groupedDictionary {
            let keys = groupedDictionary.keys.sorted()
            keys.forEach { (key) in
                groupedMatches.append(groupedDictionary[key]!)
            }
        }
        tableView.reloadData()
    }
}
//MARK: - TableViewDataSource
extension ResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedMatches.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedMatches[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.matchCellIdentifier, for: indexPath) as? MatchCell else {
            return UITableViewCell()
        }
        
        let matchData = groupedMatches[indexPath.section][indexPath.row]
        cell.homeTeamLabel.text = matchData.homeTeamName
        cell.scoreLabel.text = "\(matchData.homeTeamScore)-\(matchData.awayTeamScore)"
        cell.awayTeamLabel.text = matchData.awayTeamName
        if matchData.matchStatus == "" { // not played
            cell.timeLabel.text = "\(matchData.matchDate) \n \(matchData.matchTime)"
        }
        else { // finished or live
            if matchData.matchLive == .finished { // finished
                cell.timeLabel.text = matchData.matchStatus
            } else if matchData.matchLive == .live {
                cell.timeLabel.text = "LIVE"
            }
            else {
                cell.timeLabel.text = "ERROR"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        view.backgroundColor = .gray
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        header.backgroundColor = .black
        let label = UILabel(frame: CGRect(x: header.frame.minX, y: header.frame.minY, width: header.frame.size.width, height: header.frame.size.height))
        header.addSubview(label)
        label.text = groupedMatches[section][0].leagueName
        label.textAlignment = .center
        label.textColor = .white
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedMatches[section][0].leagueName
    }
}
//MARK: - TableViewDelegate
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC =  storyboard.instantiateViewController(withIdentifier: K.detailsViewControllerID) as! DetailsViewController
        detailsVC.match = groupedMatches[indexPath.section][indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
