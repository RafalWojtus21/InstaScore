

import Foundation

struct ScoreData : Decodable {
    let league_name : String
    let match_status : String
    let match_hometeam_name : String
    let match_hometeam_score : String
    let match_awayteam_name : String
    let match_awayteam_score : String
    let goalscorer : GoalScorer
}

struct GoalScorer : Decodable {
    let time : String
    let home_scorer : String
    let home_assist : String
    let score : String
    let away_scorer : String
    let away_assist: String
    let score_info_time : String
}
