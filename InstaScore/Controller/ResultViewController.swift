import UIKit
class ResultViewController: UIViewController{
    var scoreManager = ScoreManager()
    var date1 = ""
    var date2 = ""
    var matches: [ScoreModel] = []
    var matchByCategory: [String : [ScoreModel]] = ["" : []]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        scoreManager.delegate = self
        scoreManager.fetchScore(date1: date1, date2: date2)
        matchByCategory = Dictionary(grouping: matches) { (match) -> String in
            let param = match.league_name
            return param
        }
        print(matchByCategory)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MatchCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
}
//MARK: - ScoreManagerDelegate
extension ResultViewController: ScoreManagerDelegate{
    func didUpdateScore(scores:[ScoreModel]){
        matches = scores
        
//        let matchByCategory = Dictionary(grouping: matches) { (match) -> String in
//            let param = match.league_name
//            return param
//        }
        tableView.reloadData()
    }
}
//MARK: - TableView
extension ResultViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MatchCell
        let match = matches[indexPath.row]
        
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
