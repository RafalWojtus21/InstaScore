import UIKit
class ResultViewController: UIViewController{
    var scoreManager = ScoreManager()
    var date1 = ""
    var date2 = ""
    var matches: [ScoreModel] = []
    var matchByCategory: [String : [ScoreModel]] = ["" : []]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var leagueArray = [String]()
    var counts : [String : Int] = ["" : 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scoreManager.delegate = self
        scoreManager.fetchScore(date1: date1, date2: date2)
        matchByCategory = Dictionary(grouping: matches) { (match) -> String in
            let param = match.league_name
            return param
        }
//        print(matchByCategory)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MatchCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
}
//MARK: - ScoreManagerDelegate
extension ResultViewController: ScoreManagerDelegate{
    func didUpdateScore(scores:[ScoreModel]){
        matches = scores
        matches.sort { $0.league_name < $1.league_name }
        
        for model in matches {
            if model.league_name.contains("Championship"){
                leagueArray.append("Championship")
            } else if model.league_name.contains("Ligue 2") {
                leagueArray.append("Ligue 2")
            } else {
                leagueArray.append(model.league_name)
            }
        }

        tableView.reloadData()
    }
}
//MARK: - TableView
extension ResultViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        let set = Set(leagueArray)
        return set.count
//        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let mappedLeagues = leagueArray.map { ($0,1) }
        counts = Dictionary(mappedLeagues, uniquingKeysWith: +)
        print(counts)
//        return matches.count
        if section == 0 {
            return counts["Championship"] ?? 0

        } else if section == 1 {
            return counts["Ligue 2"] ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MatchCell
        var match = matches[indexPath.row]
        var k = 0
        if indexPath.section == 0 {
            match = matches[indexPath.row]
            for index in 0..<indexPath.row {
                k += 1
            }
        }
        if indexPath.section == 1 {
            match = matches[indexPath.row + k]
            for index in 0..<indexPath.row {
            k += 1
            }
        }
        print(k)
        print(match)
        print(indexPath.row)
        match = matches[k]
        cell.homeTeamLabel.text = match.match_hometeam_name
        cell.scoreLabel.text = "\(match.match_hometeam_score)-\(match.match_awayteam_score)"
        cell.awayTeamLabel.text = match.match_awayteam_name
        
        if match.match_status == "" { // not played
            cell.timeLabel.text = "\(match.match_date) \n \(match.match_time)"
        }
        else { // finished or live
            if match.match_live == "0" { // finished
                cell.timeLabel.text = match.match_status
            } else if match.match_live == "1" {
                cell.timeLabel.text = "LIVE"
            }
            else {
                cell.timeLabel.text = "ERROR"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        view.backgroundColor = .systemGreen
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
}
extension ResultViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC =  storyboard.instantiateViewController(withIdentifier: "DetailsStoryBoard") as! DetailsViewController
        detailsVC.matches = matches
        detailsVC.indexChosen = indexPath.row
        tableView.reloadData()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
