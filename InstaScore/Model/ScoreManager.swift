import Foundation

protocol ScoreManagerDelegate {
    func didUpdateScore(scores: [ScoreModel])
}

struct ScoreManager {
    let scoreURL = "https://apiv3.apifootball.com/?action=get_events&APIkey=a5ff78b6b29bd72f5a74923aae846c0e7b2e50f7fbd169fe30248e23a3a747ce"
    var delegate : ScoreManagerDelegate?
    
    func fetchScore(fromDate: String, toDate: String) {
        let urlString = "\(scoreURL)&from=\(fromDate)&to=\(toDate)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
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
        } catch {
            print("DECODING ERROR \(error)")
            return []
        }
    }
}

