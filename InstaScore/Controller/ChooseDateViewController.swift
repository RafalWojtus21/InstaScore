import UIKit
import CLTypingLabel

class ChooseDateViewController: UIViewController {
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    @IBOutlet weak var instaLabel: CLTypingLabel!
    
    var fromDate = ""
    var toDate = ""
    var scoreManager = ScoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        instaLabel.text = K.appName
        
        let fromDatePicker = UIDatePicker()
        setupDatePicker(datePicker: fromDatePicker)
        fromDatePicker.addTarget(self, action: #selector(dateFromChange(datePicker:)), for: UIControl.Event.valueChanged)
        dateFromTextField.inputView = fromDatePicker
        let currentDate = formatDate(date: Date())
        dateFromTextField.text = currentDate
        fromDate = currentDate
        
        let toDatePicker = UIDatePicker()
        setupDatePicker(datePicker: toDatePicker)
        toDatePicker.addTarget(self, action: #selector(dateToChange(datePicker:)), for: UIControl.Event.valueChanged)
        dateToTextField.inputView = toDatePicker
        dateToTextField.text = currentDate
        toDate = currentDate
    }
    
    func setupDatePicker(datePicker: UIDatePicker) {
        datePicker.datePickerMode = .date
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    @objc func dateFromChange(datePicker: UIDatePicker) {
        dateFromTextField.text = formatDate(date: datePicker.date)
        fromDate = formatDate(date: datePicker.date)
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func dateToChange(datePicker: UIDatePicker) {
        dateToTextField.text = formatDate(date: datePicker.date)
        toDate = formatDate(date: datePicker.date)
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    @IBAction func checkScorePressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let resultVC =  storyboard.instantiateViewController(withIdentifier: K.resultViewControllerID ) as? ResultViewController else {
            return
        }
        resultVC.fromDate = fromDate
        resultVC.toDate = toDate
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

