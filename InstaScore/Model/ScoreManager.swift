import Foundation

protocol ScoreManagerDelegate {
    func didUpdateScore(scores: [ScoreModel])
}

struct ScoreManager {
    
    let apiKey_prev = "d54be3482ce751fe1f50ff8e7394dc331a562ca86200ffd08cd5ef54dcb3a8fb"
    let apiKey = "145179df342ff37d3af721edf6f1d30d4b95c414122727a0f1c938521d6d0960"
    let scoreURL = "https://apiv3.apifootball.com/?action=get_events&league_id=153,164&APIkey=145179df342ff37d3af721edf6f1d30d4b95c414122727a0f1c938521d6d0960"
    
    var delegate : ScoreManagerDelegate?
    
    func fetchScore(fromDate: String, toDate: String) {
        let urlString = "\(scoreURL)&from=\(fromDate)&to=\(toDate)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                    let scores = self.parseJSON(scoreData: safeData)
                    DispatchQueue.main.async {
                        self.delegate?.didUpdateScore(scores: scores)
                    }
                }
            }
            
            task.resume()        
    }
    
    func parseJSON(scoreData: Data) -> [ScoreModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([ScoreModel].self, from: scoreData)
            return decodedData
        } catch{
            print(error)
            return []
        }
    }
}

