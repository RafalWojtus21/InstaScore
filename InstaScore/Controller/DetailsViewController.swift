import UIKit
class DetailsViewController: UIViewController {
    var matches : [ScoreModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(matches.count)
        for match in matches {
            let goalscorer = match.goalscorer
            print(goalscorer)
        }
    }
}
