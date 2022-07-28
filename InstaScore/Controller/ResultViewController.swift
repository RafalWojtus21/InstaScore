import UIKit



class ResultViewController: UIViewController{
    var scoreManager = ScoreManager()
    var matchesCount = 0
    var tescik = "ABC"
    
    var homeTeam = [""]
    var score = [""]
    var awayTeam = [""]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var testMatches: [Match] = []
    
    var matches: [Match] = [
        
                Match(homeTeam: "Korona", score: "1-0", awayTeam: "Wisła"),
                Match(homeTeam: "Celtic", score: "2-0", awayTeam: "Legia"),
                Match(homeTeam: "Arsenal", score: "3-0", awayTeam: "City")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scoreManager.fetchScore(date1: date1, date2: date2)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MatchCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        scoreManager.delegate = self
    }
    
    @IBAction func returnPressed(_ sender: UIButton) {
        //   self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - ScoreManagerDelegate
extension ResultViewController: ScoreManagerDelegate{
    func didUpdateScore(scores:[ScoreModel]){
        
    
        for k in 0...scores.count-1{
            let newHomeTeam = scores[k].match_hometeam_name
            let newAwayTeam = scores[k].match_awayteam_name
//            let newScore = "\(scores[k].match_hometeam_score)-\(scores[k].match_awayteam_score)"
            let newScore = scores[k].match_hometeam_score
            let newMatch = Match(homeTeam: newHomeTeam, score: newScore, awayTeam: newAwayTeam)
            self.matches.append(newMatch)
        }
        print("Meczyki halo \(matches)")
    }
}

//MARK: - TableView
extension ResultViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
        // numberofMatches
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MatchCell
        let match = matches[indexPath.row]
        cell.homeTeamLabel.text = match.homeTeam
        cell.scoreLabel.text = match.score
        cell.awayTeamLabel.text = match.awayTeam
        return cell
    }
    
    
}

extension ResultViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "goToDetails", sender: self)
        scoreManager.fetchScore(date1: date1, date2: date2)
          
    }
}
