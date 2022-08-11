import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var eventModels : [EventModel] = []
    var match : ScoreModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventModelsSetup()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.detailsCellIdentifier, bundle: nil), forCellReuseIdentifier: K.detailsCellIdentifier)
        UITableView.appearance().backgroundColor = .clear
        tableView.reloadData()
    }
    
    func eventModelsSetup() {
        if let matchDetails = match {
            var scoringTeamName = ""
            var cardReceivingTeamName = ""
            eventModels = matchDetails.goalScorer.map({
                if $0.homeScorer.isEmpty == true {
                    scoringTeamName = matchDetails.awayTeamName
                } else {
                    scoringTeamName = matchDetails.homeTeamName
                }
                return EventModel(time: $0.time, eventType: "\(K.goalAlert) \(scoringTeamName)", eventInfo: "\($0.score) - \($0.homeScorer)\($0.awayScorer)", imageName: K.goalImageName) })
            
            eventModels += matchDetails.cards.map({
                if $0.homeFault.isEmpty == true {
                    cardReceivingTeamName = matchDetails.awayTeamName
                } else {
                    cardReceivingTeamName = matchDetails.homeTeamName
                }
                return EventModel(time: $0.time, eventType: "\($0.card.uppercased()): \(cardReceivingTeamName)" , eventInfo: "\($0.homeFault)\($0.awayFault)", imageName: $0.card) })
            
            eventModels += matchDetails.substitutions.home.map({ EventModel(time: $0.time, eventType: "\(K.substitutionAlert) \(matchDetails.homeTeamName)", eventInfo: $0.substitution, imageName: K.substitutionImageName) })
            
            eventModels += matchDetails.substitutions.away.map({ EventModel(time: $0.time, eventType: "\(K.substitutionAlert) \(matchDetails.awayTeamName)", eventInfo: $0.substitution, imageName: K.substitutionImageName) })
            
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
