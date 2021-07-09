//
//  ViewController.swift
//  Project2
//
//  Created by ecinar on 25.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var answeredQuestions = 0
    var highestScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
        
        btn1.layer.borderWidth = 1
        btn2.layer.borderWidth = 1
        btn3.layer.borderWidth = 1
        btn1.layer.borderColor = UIColor.lightGray.cgColor
        btn2.layer.borderColor = UIColor.lightGray.cgColor
        btn3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
        let defaults = UserDefaults.standard

        if let highScore = defaults.object(forKey: "highestScore") as? Int{
            highestScore = highScore
        }
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        btn1.setImage(UIImage(named: countries[0]), for: .normal)
        btn2.setImage(UIImage(named: countries[1]), for: .normal)
        btn3.setImage(UIImage(named: countries[2]), for: .normal)
    }
  
    @IBAction func btnTapped(_ sender: UIButton) {
        answeredQuestions += 1
        if sender.tag == correctAnswer{
            score += 1
            title = "Correct your score is: \(score)"
            if  score > highestScore {
                title = "Correct. You pass the previous highestScore. Your Score is \(score)"
                highestScore = score
                let defaults = UserDefaults.standard
                defaults.set(highestScore, forKey: "highestScore")
            }
        }else{
            score -= 1
            title = "Wrong, your score is: \(score)"
        }
        
        
        if answeredQuestions != 10 {
            let ac = UIAlertController(title:title, message: prepaperMessageForAlert(buttonTag: sender.tag) , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }else {
            let ac = UIAlertController(title:title, message: prepaperMessageForAlert(buttonTag: sender.tag) , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score = 0
            answeredQuestions = 0
            
        }
       
    }
    
    func prepaperMessageForAlert(buttonTag: Int) ->String {
        var answerMessage: String

        if buttonTag != correctAnswer{
          answerMessage = "Wrong the correct flag is \(countries[correctAnswer])"
        }else {
            answerMessage = "Correct"
        }
        return answerMessage
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Scorun bu " , message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default))
        present(ac, animated: true)
        
    }
    
}

