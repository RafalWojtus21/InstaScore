import UIKit
class ResultViewController: UIViewController {
    
    var scoreManager = ScoreManager()
    var fromDate = ""
    var toDate = ""
    var matches: [ScoreModel] = []
    var groupedDictionary: [String: [ScoreModel]]?
    var groupedMatches: [[ScoreModel]] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.matchCellNibName, bundle: nil), forCellReuseIdentifier: K.matchCellIdentifier)
    }
    
    func setupView() {
        scoreManager.delegate = self
        scoreManager.fetchScore(fromDate: fromDate, toDate: toDate)
    }
}
//MARK: - ScoreManagerDelegate
extension ResultViewController: ScoreManagerDelegate {
    func didUpdateScore(scores: [ScoreModel]) {
        matches = scores
        matches.sort { $0.league_name < $1.league_name }
        groupedDictionary = Dictionary(grouping: matches) { (league) -> String in
            return league.league_name
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
        cell.homeTeamLabel.text = matchData.match_hometeam_name
        cell.scoreLabel.text = "\(matchData.match_hometeam_score)-\(matchData.match_awayteam_score)"
        cell.awayTeamLabel.text = matchData.match_awayteam_name
        if matchData.match_status == "" { // not played
            cell.timeLabel.text = "\(matchData.match_date) \n \(matchData.match_time)"
        }
        else { // finished or live
            if matchData.match_live == "0" { // finished
                cell.timeLabel.text = matchData.match_status
            } else if matchData.match_live == "1" {
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
        label.text = groupedMatches[section][0].league_name
        label.textAlignment = .center
        label.textColor = .white
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedMatches[section][0].league_name
    }
}
//MARK: - TableViewDelegate
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC =  storyboard.instantiateViewController(withIdentifier: "DetailsStoryBoard") as! DetailsViewController
        detailsVC.match = groupedMatches[indexPath.section][indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
