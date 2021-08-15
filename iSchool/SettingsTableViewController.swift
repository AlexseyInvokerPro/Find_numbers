//
//  SettingsTableViewController.swift
//  iSchool
//
//  Created by Алексей Авдейчик on 11.05.21.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var switchTimer: UISwitch!
    @IBOutlet weak var timeGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettings.timerState = sender.isOn
        switchTimer.isOn = Settings.shared.currentSettings.timerState
    }
    
    func loadSettings() {
        timeGameLabel.text = "\(Settings.shared.currentSettings.timeForGame) sec"
    }
    @IBAction func resetSettings(_ sender: Any) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.data = [20,25,30,35,40,45,50,55,60,65,70,75,80]
            }
        default:
            break
        }
    }
}
