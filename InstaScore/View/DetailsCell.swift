import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        minuteLabel.numberOfLines = 1
//        minuteLabel.minimumScaleFactor = 1
        minuteLabel.adjustsFontSizeToFitWidth = true
        minuteLabel.font = UIFont.boldSystemFont(ofSize: 16)
        eventLabel.numberOfLines = 0
        eventLabel.adjustsFontSizeToFitWidth = true
        eventLabel.font = UIFont.boldSystemFont(ofSize: 16)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
