//
//  ViewController.swift
//  iSchool
//
//  Created by User on 6.05.21.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, time) in
        
        guard let self = self else {return}
        
        self.timerLabel.text = time.secondsToString()
        
        self.updateInfoGame(with: status)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    
    @IBAction func pressButton(_ sender: UIButton) {
        
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    
    private func setupScreen (){
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            //            buttons[index].isHidden = false
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
            buttons[index].layer.cornerRadius = 12
            buttons[index].layer.borderWidth = 0.9
        }
        
        nextDigit.text = game.nextItem?.title
    }
    
    func updateUI(){
        for index in game.items.indices {
            //            buttons[index].isHidden = game.items[index].isFound
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            if game.items[index].isError {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .systemOrange
                    self?.game.items[index].isError = false
                }
                
            }
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame) {
        switch status {
        case .start:
            statusLabel.text = "Start game"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "You're win!"
            statusLabel.textColor = .systemGreen
            newGameButton.isHidden = false
            newGameButton.layer.cornerRadius = 10
            newGameButton.layer.borderWidth = 0.9
            if game.isNewRecord {
                showAlert()
            } else {
                showAlertAcionSheet()
            }
        case .lose:
            statusLabel.text = "Loser ;) try again"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            newGameButton.layer.cornerRadius = 10
            newGameButton.layer.borderWidth = 0.9
            showAlertAcionSheet()
        }
    }
    
    private func showAlert() {
        
        let alert = UIAlertController(title: "Congrad", message: "New record", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertAcionSheet() {
        let alert = UIAlertController(title: "What next?", message: nil, preferredStyle: .actionSheet)
        let newGameAction = UIAlertAction(title: "New game", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        
        
        let showRecord = UIAlertAction(title: "Watch the recrd", style: .default) { [weak self] (_) in self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        
        let menuAction = UIAlertAction(title: "Go to menu", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "otmena", style: .cancel, handler: nil)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

