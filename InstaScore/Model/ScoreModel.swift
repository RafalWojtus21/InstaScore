import Foundation

struct ScoreModel: Codable {
    let leagueName: String
    let matchStatus: String
    let matchDate: String
    let matchTime: String
    let matchLive: String 
    let homeTeamName: String
    let homeTeamScore: String
    let awayTeamName: String
    let awayTeamScore: String
    let goalScorer: [GoalScorer]
    let cards: [Cards]
    let substitutions: Substitutions
    
    private enum CodingKeys: String, CodingKey {
        case leagueName = "league_name"
        case matchStatus = "match_status"
        case matchDate = "match_date"
        case matchTime = "match_time"
        case matchLive = "match_live"
        case homeTeamName = "match_hometeam_name"
        case homeTeamScore = "match_hometeam_score"
        case awayTeamName = "match_awayteam_name"
        case awayTeamScore = "match_awayteam_score"
        case goalScorer = "goalscorer"
        case cards = "cards"
        case substitutions = "substitutions"
    }
}

struct GoalScorer: Codable {
    let time: String
    let homeScorer: String
    let homeAssist: String
    let score: String
    let awayScorer: String
    let awayAssist: String
    let scoreTime: String
    
    private enum CodingKeys: String, CodingKey {
        case time = "time"
        case homeScorer = "home_scorer"
        case homeAssist =  "home_assist"
        case score = "score"
        case awayScorer = "away_scorer"
        case awayAssist = "away_assist"
        case scoreTime = "score_info_time"
    }
}

struct Cards: Codable {
    let time: String
    let homeFault: String
    let card: String
    let awayFault: String
    
    private enum CodingKeys: String, CodingKey {
        case time = "time"
        case homeFault = "home_fault"
        case card = "card"
        case awayFault = "away_fault"
    }
}

struct Substitutions: Codable {
    let home: [Home]
    let away: [Away]
}

struct Home: Codable {
    let time: String
    let substitution: String
}

struct Away: Codable {
    let time: String
    let substitution: String
}
