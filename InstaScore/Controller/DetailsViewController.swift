import UIKit
class DetailsViewController: UIViewController {
    var indexChosen = 0
    var matches : [ScoreModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
 
        print(matches[indexChosen].goalscorer)
        print(matches[indexChosen].cards)
        print(matches[indexChosen].substitutions.home)
        print(matches[indexChosen].substitutions.away)
        
    }
}


//MARK: - Tableview extensions
extension DetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // let numberOfEvents = matches[indexChosen].goalscorer.count + matches[indexChosen].cards.count + matches[indexChosen].substitutions[0].home.count + matches[indexChosen].substitutions[1].away.count
        let goalScorerDetails = matches[indexChosen].goalscorer
        let cardsDetails = matches[indexChosen].cards
        let homeSubstitutionsDetails = matches[indexChosen].substitutions.home
        let awaySubstitutionsDetails = matches[indexChosen].substitutions.away
        let numberOfEvents = goalScorerDetails.count + cardsDetails.count + homeSubstitutionsDetails.count + awaySubstitutionsDetails.count
        return numberOfEvents
//        return goalScorerDetails.count
    }
    

    func sortData() {
        let goalScorerDetails = matches[indexChosen].goalscorer as! ScoreModel
        let cardsDetails = matches[indexChosen].cards as! ScoreModel
        let homeSubstitutionsDetails = matches[indexChosen].substitutions.home as! ScoreModel
        let awaySubstitutionsDetails = matches[indexChosen].substitutions.away as! ScoreModel
        var events = [String : ScoreModel]()



    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        let goalscorerDetails = matches[indexChosen].goalscorer
        let cardsDetails = matches[indexChosen].cards
        let homeSubstitutionsDetails = matches[indexChosen].substitutions.home
        let awaySubstitutionsDetails = matches[indexChosen].substitutions.away
        
        let firstThreshold = goalscorerDetails.count + cardsDetails.count
        let secondThreshold = firstThreshold + homeSubstitutionsDetails.count
        let thirdThreshold = secondThreshold + awaySubstitutionsDetails.count
        
        if indexPath.row < goalscorerDetails.count {
            cell.minuteLabel.text = "\(goalscorerDetails[indexPath.row].time)'"
//            cell.eventLabel.text =  "\(goalscorerDetails[indexPath.row].score) - \(goalscorerDetails[indexPath.row].home_scorer)\(goalscorerDetails[indexPath.row].away_scorer)"
            cell.eventLabel.text = convertEventLabel(eventType: "GOAL", event: "\(goalscorerDetails[indexPath.row].score) - \(goalscorerDetails[indexPath.row].home_scorer)\(goalscorerDetails[indexPath.row].away_scorer)")
        } else if indexPath.row < firstThreshold {
//            cell.minuteLabel.text = cardsDetails[indexPath.row - goalscorerDetails.count].time
            cell.minuteLabel.text = convertMinuteLabel(time: cardsDetails[indexPath.row - goalscorerDetails.count].time)
            cell.eventLabel.text = convertEventLabel(eventType: cardsDetails[indexPath.row - goalscorerDetails.count].card.uppercased(), event: "\(cardsDetails[indexPath.row - goalscorerDetails.count].home_fault)\(cardsDetails[indexPath.row - goalscorerDetails.count].away_fault)")
        } else if indexPath.row < secondThreshold {
            cell.minuteLabel.text = convertMinuteLabel(time: homeSubstitutionsDetails[indexPath.row - firstThreshold].time)
            cell.eventLabel.text = convertEventLabel(eventType: "HOME - SUBSTITUTION", event: homeSubstitutionsDetails[indexPath.row - firstThreshold].substitution)
        } else if indexPath.row < thirdThreshold  {
            cell.minuteLabel.text = convertMinuteLabel(time: awaySubstitutionsDetails[indexPath.row - secondThreshold].time)
            cell.eventLabel.text = convertEventLabel(eventType: "AWAY - SUBSTITUTION", event: awaySubstitutionsDetails[indexPath.row - secondThreshold].substitution)
        } else {
            cell.minuteLabel.text = ""
            cell.eventLabel.text = ""
        }

        return cell
    }
    
    func convertMinuteLabel(time : String) -> String {
        let convertedString = "\(time)'"
        return convertedString
    }
    
    func convertEventLabel(eventType : String, event : String) -> String {
        let convertedString = "\(eventType): \(event)"
        return convertedString
    }
    
}
extension DetailsViewController: UITableViewDelegate{
}
