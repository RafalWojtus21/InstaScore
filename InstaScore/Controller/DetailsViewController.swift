import UIKit
class DetailsViewController: UIViewController {
    var passDataModel : PassDataModel = PassDataModel(sectionChosen: 9999, indexChosen: 9999, matchesGrouped: [])
    var eventModels : [EventModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventModelsSetup()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        UITableView.appearance().backgroundColor = .clear
        tableView.reloadData()
    }
    func eventModelsSetup() {
        let matchesGrouped = passDataModel.matchesGrouped
        let sectionChosen = passDataModel.sectionChosen
        let indexChosen = passDataModel.indexChosen
        let matchDetails = matchesGrouped[sectionChosen][indexChosen]
        
        if matchesGrouped[sectionChosen][indexChosen].goalscorer.count > 0 {
        eventModels = matchDetails.goalscorer.map({ EventModel(time: $0.time, eventType: "GOAL: \(matchDetails.match_hometeam_name)", eventInfo: "\($0.score) - \($0.home_scorer)\($0.away_scorer)", imageName: "goal") })
        }

        if matchDetails.cards.count > 0 {
            eventModels += matchDetails.cards.map({ EventModel(time: $0.time, eventType: "\($0.card.uppercased()): \(matchDetails.match_hometeam_name)" , eventInfo: "\($0.home_fault)\($0.away_fault)", imageName: $0.card) })
        }

        if matchDetails.substitutions.home.count > 0 {
        eventModels += matchDetails.substitutions.home.map({EventModel(time: $0.time, eventType: "SUBSTITUTION: \(matchDetails.match_hometeam_name)", eventInfo: $0.substitution, imageName: "substitution")})
        }
        
        if matchDetails.substitutions.away.count > 0 {
        eventModels += matchDetails.substitutions.away.map({EventModel(time: $0.time, eventType: "SUBSTITUTION: \(matchDetails.match_awayteam_name)", eventInfo: $0.substitution, imageName: "substitution")})
        }
        
        eventModels = eventModels.sorted(by: { $0.time.localizedStandardCompare($1.time) == .orderedAscending})
    }
}
//MARK: - Tableview extensions
extension DetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        cell.minuteLabel.text = "\(String(eventModels[indexPath.row].time))'"
        cell.eventLabel.text = "\(eventModels[indexPath.row].eventType) \n \(eventModels[indexPath.row].eventInfo)"
        cell.eventImage.image = UIImage(named: eventModels[indexPath.row].imageName)
        return cell
    } 
}
extension DetailsViewController: UITableViewDelegate{
}
