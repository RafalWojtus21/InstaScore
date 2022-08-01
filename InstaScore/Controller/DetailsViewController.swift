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
//        return numberOfEvents
        return goalScorerDetails.count
    }
    

    func sortData() {
        let goalScorerDetails = matches[indexChosen].goalscorer
        let cardsDetails = matches[indexChosen].cards
        let homeSubstitutionsDetails = matches[indexChosen].substitutions.home
        let awaySubstitutionsDetails = matches[indexChosen].substitutions.away
//        var events = [Any : Any] ()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        let goalscorerDetails = matches[indexChosen].goalscorer
        cell.minuteLabel.text = ""
        cell.eventLabel.text =  goalscorerDetails[indexPath.row].score

        return cell
    }
    

}

extension DetailsViewController: UITableViewDelegate{

}
