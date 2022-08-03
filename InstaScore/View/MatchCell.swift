//
//  MatchCell.swift
//  InstaScore
//
//  Created by Gość on 27/07/2022.
//

import UIKit

class MatchCell: UITableViewCell {

    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeLabel.numberOfLines = 0
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.font = UIFont.boldSystemFont(ofSize: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
