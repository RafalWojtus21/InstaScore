import UIKit
import CLTypingLabel
class ChooseDateViewController: UIViewController{
    
    var date1 = "2022-08-01"
    var date2 = "2022-08-05"
//    var date1 = "2022-08-06"
//    var date2 = "2022-08-06"
    var scoreManager = ScoreManager()
    
    @IBOutlet weak var dateTF1: UITextField!
    @IBOutlet weak var dateTF2: UITextField!
    @IBOutlet weak var instaLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instaLabel.text = "⚡️instaScore"

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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resultVC =  storyboard.instantiateViewController(withIdentifier: "ResultStoryBoard") as! ResultViewController
        resultVC.date1 = date1
        resultVC.date2 = date2
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

