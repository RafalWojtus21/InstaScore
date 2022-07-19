
import Foundation

// https://apiv3.apifootball.com/?action=get_events&league_id=153&APIkey=d54be3482ce751fe1f50ff8e7394dc331a562ca86200ffd08cd5ef54dcb3a8fb&from=2022-05-20&to=2022-05-30


struct ScoreManager{
    let scoreURL = "https://apiv3.apifootball.com/?action=get_events&league_id=153&APIkey=d54be3482ce751fe1f50ff8e7394dc331a562ca86200ffd08cd5ef54dcb3a8fb"
    

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
                if let safeData = data {
                    self.parseJSON(scoreData: safeData)
                }
            }
            
            task.resume()
            
            
        }
    }
      
    
    func parseJSON(scoreData: Data){
        let decoder = JSONDecoder()
        do {
//            let decodedData = try decoder.decode([GoalScorer].self, from: scoreData)		
            let decodedData = try decoder.decode([ScoreData].self, from: scoreData)
            for numberOfMatches in 0 ... decodedData.count-1{
            print(decodedData[numberOfMatches].match_hometeam_name)
            }
        } catch{
            print(error)
        }
    }
    
    }

