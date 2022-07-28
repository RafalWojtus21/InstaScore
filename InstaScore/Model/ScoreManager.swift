import Foundation
// https://apiv3.apifootball.com/?action=get_events&league_id=153&APIkey=d54be3482ce751fe1f50ff8e7394dc331a562ca86200ffd08cd5ef54dcb3a8fb&from=2022-05-20&to=2022-05-30

protocol ScoreManagerDelegate {
    func didUpdateScore(scores: [ScoreModel])
}

struct ScoreManager{

    
    let scoreURL = "https://apiv3.apifootball.com/?action=get_events&league_id=153&APIkey=d54be3482ce751fe1f50ff8e7394dc331a562ca86200ffd08cd5ef54dcb3a8fb"
    
    var delegate : ScoreManagerDelegate?
    
    func fetchScore(date1: String, date2: String){
        let urlString = "\(scoreURL)&from=\(date1)&to=\(date2)"
        performRequest(urlString: urlString)

        
    }

    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                    let scores = self.parseJSON(scoreData: safeData)
                    self.delegate?.didUpdateScore(scores: scores)
                }
            }
            
            task.resume()
            
            
        }
    }

    func parseJSON(scoreData: Data) -> [ScoreModel]{
        let decoder = JSONDecoder()
        var matchesNumber = 0
        var score : [ScoreModel] = []
        // var scoredata : [ScoreData] = []
        do {

            let decodedData = try decoder.decode([ScoreData].self, from: scoreData)
            // let decodedData = try decoder.decode([GoalScorer].self, from: scoreData)
            matchesNumber = decodedData.count
            for numberOfMatches in 0 ... decodedData.count-1{
                
                let filteredData = decodedData[numberOfMatches]
                // var goalScorerModel : [GoalScorer] = []
                // goalScorerModel.append(filteredData.goalscorer[numberOfMatches])
                let leagueName = filteredData.league_name
                let matchStatus = filteredData.match_status
                let homeTeamName = filteredData.match_hometeam_name
                let awayTeamName = filteredData.match_awayteam_name
                let homeTeamScore = filteredData.match_hometeam_score
                let awayTeamScore = filteredData.match_awayteam_score
                
                // let scoreToAppend2 = ScoreData(league_name: leagueName, match_status: matchStatus, match_hometeam_name: homeTeamName, match_hometeam_score: homeTeamScore, match_awayteam_name: awayTeamName, match_awayteam_score: awayTeamScore, goalscorer: goalScorerModel)
                let scoreToAppend = ScoreModel(league_name: leagueName, match_status: matchStatus, match_hometeam_name: homeTeamName, match_hometeam_score: homeTeamScore, match_awayteam_name: awayTeamName, match_awayteam_score: awayTeamScore)
                score.append(scoreToAppend)
                // scoredata.append(scoreToAppendd)
            }

            // print ("SCOREDATA \(scoredata)")
   
            return score
        } catch{
            print(error)
            return []
        }
    }
        
}

