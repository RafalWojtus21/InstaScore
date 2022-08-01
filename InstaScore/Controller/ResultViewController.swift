import UIKit

class ResultViewController: UIViewController{
    var scoreManager = ScoreManager()
    var date1 = ""
    var date2 = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonStackView: UIStackView!

    var matches: [ScoreModel] = [
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    
        scoreManager.delegate = self
        scoreManager.fetchScore(date1: date1, date2: date2)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MatchCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        let imageView = UIImageView(image: #imageLiteral(resourceName: "field"))
        tableView.backgroundView = imageView
    }
    @IBAction func returnPressed(_ sender: UIButton) {
        //   self.dismiss(animated: true, completion: nil)
    }
}
//MARK: - ScoreManagerDelegate
extension ResultViewController: ScoreManagerDelegate{
    func didUpdateScore(scores:[ScoreModel]){
        matches = scores
        tableView.reloadData()
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
        cell.homeTeamLabel.text = match.match_hometeam_name
        cell.scoreLabel.text = "\(match.match_hometeam_score)-\(match.match_awayteam_score)"
        cell.awayTeamLabel.text = match.match_awayteam_name
        return cell
    }
}

extension ResultViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "goToDetails", sender: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC =  storyboard.instantiateViewController(withIdentifier: "DetailsStoryBoard") as! DetailsViewController
        detailsVC.matches = matches
        detailsVC.indexChosen = indexPath.row
        self.present(detailsVC, animated: true)
    }
}
