//
//  RecordViewController.swift
//  iSchool
//
//  Created by User on 18.05.21.
//

import UIKit

class RecordViewController: UIViewController {
    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let record = UserDefaults.standard.integer(forKey: KeyUserDefaults.recordGame)
        
        if record != 0 {
            recordLabel.text = "You'r record is - \(record)"
        } else {
            recordLabel.text = "Record is not set"
        }
    }
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
