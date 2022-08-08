import Foundation

struct ScoreModel : Codable {
    let league_name : String
    let match_status : String
    let match_date : String
    let match_time : String
    let match_live : String // 1-live, 0-finished
    let match_hometeam_name : String
    let match_hometeam_score : String
    let match_awayteam_name : String
    let match_awayteam_score : String
    let goalscorer : [GoalScorer]
    let cards : [Cards]
    let substitutions : Substitutions
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

struct Cards : Codable {
    let time : String
    let home_fault : String
    let card : String
    let away_fault : String
}

struct Substitutions : Codable {
    let home : [Home]
    let away : [Away]
}

struct Home : Codable {
    let time : String
    let substitution : String
}

struct Away : Codable {
    let time : String
    let substitution : String
}
