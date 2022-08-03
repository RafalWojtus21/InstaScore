import UIKit
class DetailsViewController: UIViewController {
    var indexChosen : Int = 9999 {
        didSet {
            if indexChosen != 9999 && matches != nil {
                eventModelsSetup()
            }
        }
    }
    var matches : [ScoreModel] = [] {
        didSet {
            if indexChosen != 9999 && matches != nil {
            eventModelsSetup()
            }
        }
    }
    
    var eventModels : [EventModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        UITableView.appearance().backgroundColor = .clear
        tableView.reloadData()
//        print(matches[indexChosen].goalscorer)
//        print(matches[indexChosen].cards)
//        print(matches[indexChosen].substitutions.home)
//        print(matches[indexChosen].substitutions.away)
//        let numberOfEvents = matches[indexChosen].goalscorer.count + matches[indexChosen].cards.count + matches[indexChosen].substitutions.home.count + matches[indexChosen].substitutions.away.count
//        print("TOTAL NUMBER OF EVENTS: \(numberOfEvents)")
//        print("INDEX CHOSEN : \(indexChosen)")
    }
    func eventModelsSetup() {
        if matches[indexChosen].goalscorer.count > 0 {
        eventModels = matches[indexChosen].goalscorer.map({ EventModel(time: $0.time, eventType: "GOAL: \(matches[indexChosen].match_hometeam_name)", eventInfo: "\($0.score) - \($0.home_scorer)\($0.away_scorer)", imageName: "goal") })
        }

        if matches[indexChosen].cards.count > 0 {
            eventModels += matches[indexChosen].cards.map({ EventModel(time: $0.time, eventType: "\($0.card.uppercased()): \(matches[indexChosen].match_hometeam_name)" , eventInfo: "\($0.home_fault)\($0.away_fault)", imageName: $0.card) })
        }

        if matches[indexChosen].substitutions.home.count > 0 {
        eventModels += matches[indexChosen].substitutions.home.map({EventModel(time: $0.time, eventType: "SUBSTITUTION: \(matches[indexChosen].match_hometeam_name)", eventInfo: $0.substitution, imageName: "substitution")})
        }
        
        if matches[indexChosen].substitutions.away.count > 0 {
        eventModels += matches[indexChosen].substitutions.away.map({EventModel(time: $0.time, eventType: "SUBSTITUTION: \(matches[indexChosen].match_awayteam_name)", eventInfo: $0.substitution, imageName: "substitution")})
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
