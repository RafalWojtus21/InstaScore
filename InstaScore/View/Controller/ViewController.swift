//2022-05-20 2022-05-30

import UIKit
var scoreManager = ScoreManager()
var date1 = "2022-05-02"
var date2 = "2022-05-04"
class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func dateChosen(_ sender: UIDatePicker) {
        var chosenDate = datePicker.date
        scoreManager.fetchScore(date1: date1, date2: date2)
        // print (scoreManager.fetchScore(date1: date1, date2: date2))
    }
    

    
}

