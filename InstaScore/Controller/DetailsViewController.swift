import UIKit
class DetailsViewController: UIViewController {
    var eventModels: [EventModel] = []
    var match: ScoreModel?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventModelsSetup()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.detailsCellNibName, bundle: nil), forCellReuseIdentifier: K.detailsCellIdentifier)
        UITableView.appearance().backgroundColor = .clear
        tableView.reloadData()
    }
    
    func eventModelsSetup() {
        if let matchDetails = match {
            eventModels = matchDetails.goalscorer.map({ EventModel(time: $0.time, eventType: "GOAL: \(matchDetails.match_hometeam_name)", eventInfo: "\($0.score) - \($0.home_scorer)\($0.away_scorer)", imageName: K.goalImageName) })
            
            eventModels += matchDetails.cards.map({ EventModel(time: $0.time, eventType: "\($0.card.uppercased()): \(matchDetails.match_hometeam_name)" , eventInfo: "\($0.home_fault)\($0.away_fault)", imageName: $0.card) })
            
            eventModels += matchDetails.substitutions.home.map({ EventModel(time: $0.time, eventType: "SUBSTITUTION: \(matchDetails.match_hometeam_name)", eventInfo: $0.substitution, imageName: K.substitutionImageName) })
            
            eventModels += matchDetails.substitutions.away.map({ EventModel(time: $0.time, eventType: "SUBSTITUTION: \(matchDetails.match_awayteam_name)", eventInfo: $0.substitution, imageName: K.substitutionImageName) })
            
            eventModels = eventModels.sorted(by: { $0.time.localizedStandardCompare($1.time) == .orderedAscending })
        }
    }
}
//MARK: - Tableview extensions
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.detailsCellIdentifier, for: indexPath) as? DetailsCell else {
            return UITableViewCell()
        }
        cell.minuteLabel.text = String(eventModels[indexPath.row].time) + "'"
        cell.eventLabel.text = "\(eventModels[indexPath.row].eventType)"
        cell.eventInfoLabel.text = "\(eventModels[indexPath.row].eventInfo)"
        cell.eventImage.image = UIImage(named: eventModels[indexPath.row].imageName)
        return cell
    }
}
extension DetailsViewController: UITableViewDelegate {
}
