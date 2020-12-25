//
//  ViewController.swift
//  RockScissorsPaper
//
//  Created by Игорь Пенкин on 18.09.2020.
//  Copyright © 2020 Igor-A-Penkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var statuslabel: UILabel!
    @IBOutlet weak var robotButton: UIButton!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetButton.isHidden = true
    }
    
    func play(sign: Sign) {
        let computerSign = randomSign()
        robotButton.setTitle(computerSign.emoji, for: .normal)
        
        switch sign {
        case .rock:
            rockButton.isHidden = false
            paperButton.isHidden = true
            scissorsButton.isHidden = true
        case .paper:
            rockButton.isHidden = true
            paperButton.isHidden = false
            scissorsButton.isHidden = true
        case .scissors:
            rockButton.isHidden = true
            paperButton.isHidden = true
            scissorsButton.isHidden = false
        }
        resetButton.isHidden = false
        
        let result = sign.getResult(for: computerSign)
        
        switch result {
        case .win:
            statuslabel.text = "You have won!"
            //self.view.backgroundColor = UIColor.green
        case .start:
            reset()
        case .lose:
            statuslabel.text = "You have lost!"
            //self.view.backgroundColor = UIColor.red
        case .draw:
            statuslabel.text = "It is a draw!"
            //self.view.backgroundColor = UIColor.systemGray6
        }
    }
    
    func reset() {
        statuslabel.text = "Rock, Paper or Scissors?"
        //self.view.backgroundColor = UIColor.white
        rockButton.isHidden = false
        paperButton.isHidden = false
        scissorsButton.isHidden = false
        resetButton.isHidden = true
        robotButton.setTitle("🤖", for: .normal)
    }
    
    // MARK: - IBAction
    
    @IBAction func rockButtonPressed(_ sender: Any) {
        play(sign: .rock)
    }
    
    @IBAction func paperButtonPressed(_ sender: Any) {
        play(sign: .paper)
    }
    
    @IBAction func scissorsButtonPressed(_ sender: Any) {
        play(sign: .scissors)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        reset()
    } 
}

