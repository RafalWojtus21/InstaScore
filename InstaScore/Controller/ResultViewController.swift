import UIKit
class ResultViewController: UIViewController{
    var scoreManager = ScoreManager()
    var date1 = ""
    var date2 = ""
    var matches: [ScoreModel] = []
    var matchByCategory: [String : [ScoreModel]] = ["" : []]
    var matchesGrouped : [[ScoreModel]] = []
    
    var championshipMatches : [ScoreModel] = []
    var ligue2Matches : [ScoreModel] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var leagueArray = [String]()
    var counts : [String : Int] = ["" : 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scoreManager.delegate = self
        scoreManager.fetchScore(date1: date1, date2: date2)
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
        championshipMatches = matches.filter { (a) -> Bool in
            return a.league_name.contains("Championship")
        }
        ligue2Matches = matches.filter { (a) -> Bool in
            return a.league_name.contains("Ligue 2")
        }
        matchesGrouped.append(championshipMatches)
        matchesGrouped.append(ligue2Matches)
        tableView.reloadData()
    }
}
//MARK: - TableView
extension ResultViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchesGrouped.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesGrouped[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MatchCell
        var homeLabel = ""
        var scoreLabel = ""
        var awayLabel = ""
        let matchData = matchesGrouped[indexPath.section][indexPath.row]
        
        homeLabel = matchData.match_hometeam_name
        scoreLabel = "\(matchData.match_hometeam_score)-\(matchData.match_awayteam_score)"
        awayLabel = matchData.match_awayteam_name
        cell.homeTeamLabel.text = homeLabel
        cell.scoreLabel.text = scoreLabel
        cell.awayTeamLabel.text = awayLabel
        
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
        label.text = matchesGrouped[section][0].league_name
        label.textAlignment = .center
        label.textColor = .white
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return matchesGrouped[section][0].league_name
    }
}
extension ResultViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC =  storyboard.instantiateViewController(withIdentifier: "DetailsStoryBoard") as! DetailsViewController
        detailsVC.passDataModel.indexChosen = indexPath.row
        detailsVC.passDataModel.sectionChosen = indexPath.section
        detailsVC.passDataModel.matchesGrouped = matchesGrouped
        tableView.reloadData()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
