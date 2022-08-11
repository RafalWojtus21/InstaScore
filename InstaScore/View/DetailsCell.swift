import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventInfoLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        minuteLabel.numberOfLines = 1
        minuteLabel.adjustsFontSizeToFitWidth = true
        minuteLabel.font = UIFont.boldSystemFont(ofSize: 16)
        eventLabel.numberOfLines = 0
        eventLabel.adjustsFontSizeToFitWidth = true
        eventLabel.font = UIFont.boldSystemFont(ofSize: 16)
        eventInfoLabel.numberOfLines = 0
        eventInfoLabel.adjustsFontSizeToFitWidth = true
        eventInfoLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
}
