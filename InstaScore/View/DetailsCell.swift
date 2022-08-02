import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        minuteLabel.numberOfLines = 1
//        minuteLabel.minimumScaleFactor = 1
        minuteLabel.adjustsFontSizeToFitWidth = true
        eventLabel.numberOfLines = 1
        eventLabel.adjustsFontSizeToFitWidth = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
