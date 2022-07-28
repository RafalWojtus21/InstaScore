import Foundation

struct ScoreData : Codable {
    let league_name : String
    let match_status : String
    let match_hometeam_name : String
    let match_hometeam_score : String
    let match_awayteam_name : String
    let match_awayteam_score : String
    let goalscorer : [GoalScorer]
    
//    enum CodingKeys : String, CodingKey {
//        case leagueName = "league_name"
//    }
}

struct GoalScorer : Codable {
    let time : String
    let home_scorer : String
    let home_assist : String
    let score : String
    let away_scorer : String
    let away_assist: String
    let score_info_time : String
}
