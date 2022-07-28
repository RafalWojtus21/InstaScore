import UIKit
import CLTypingLabel

var date1 = "2022-05-01"
var date2 = "2022-05-03"
let zmiana2testowe = "zmiana"
class ChooseDateViewController: UIViewController, ScoreManagerDelegate{
    
    var scoreManager = ScoreManager()
    
    @IBOutlet weak var dateTF1: UITextField!
    @IBOutlet weak var dateTF2: UITextField!
    @IBOutlet weak var instaLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instaLabel.text = "instaScore"
        
        // Do any additional setup after loading the view.
        scoreManager.delegate = self

        let datePicker1 = UIDatePicker()
        datePicker1.datePickerMode = .date
        datePicker1.addTarget(self, action: #selector(dateFromChange(datePicker:)), for: UIControl.Event.valueChanged)
        
        datePicker1.frame.size = CGSize(width: 0, height: 300)
        datePicker1.preferredDatePickerStyle = .wheels
        
        dateTF1.inputView = datePicker1
        dateTF1.text = formatDate(date: Date())
                
        let datePicker2 = UIDatePicker()
        datePicker2.datePickerMode = .date
        datePicker2.addTarget(self, action: #selector(dateToChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker2.frame.size = CGSize(width: 0, height: 300)
        datePicker2.preferredDatePickerStyle = .wheels
        dateTF2.inputView = datePicker2
        dateTF2.text = formatDate(date: Date())
        
        
        
    }
    
    
    @objc func dateFromChange(datePicker: UIDatePicker){
        dateTF1.text = formatDate(date: datePicker.date)
        // date1 = formatDate(date: datePicker.date)
        print("Date from \(date1)")
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func dateToChange(datePicker: UIDatePicker){
        dateTF2.text = formatDate(date: datePicker.date)
        // date2 = formatDate(date: datePicker.date)
        print("Date to \(date2)")
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    
    @IBAction func checkScorePressed(_ sender: UIButton) {
        scoreManager.fetchScore(date1: date1, date2: date2)
    }
    
    func didUpdateScore(scores:[ScoreModel]){
        
        
        DispatchQueue.main.async {
        let resultVC = ResultViewController()
        resultVC.tescik = "HALKO"
        }
  
//         print(scores[0].match_hometeam_name)
    }
    

    
}

