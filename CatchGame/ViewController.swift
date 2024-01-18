//
//  ViewController.swift
//  CatchGame
//
//  Created by Eda Vural on 18.01.2024.
//

import UIKit

class ViewController: UIViewController {

    // Variables
    var score = 0
    var timer = Timer()
    var count = 20
    var imgArray = [UIImageView]()
    var timerHide = Timer()
    var highscore = 0
    
    //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var cat9: UIImageView!
    @IBOutlet weak var cat8: UIImageView!
    @IBOutlet weak var cat7: UIImageView!
    @IBOutlet weak var cat6: UIImageView!
    @IBOutlet weak var cat5: UIImageView!
    @IBOutlet weak var cat4: UIImageView!
    @IBOutlet weak var cat3: UIImageView!
    @IBOutlet weak var cat2: UIImageView!
    @IBOutlet weak var cat1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // highscore check and compare
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highscore = 0
            highscoreLabel.text = "HighScore : \(highscore)"
        }
        if let newScore = storedHighScore as? Int {
            highscore = newScore
            highscoreLabel.text = "HighScore : \(highscore)"
        }
        
        // for clicked
        cat1.isUserInteractionEnabled = true
        cat2.isUserInteractionEnabled = true
        cat3.isUserInteractionEnabled = true
        cat4.isUserInteractionEnabled = true
        cat5.isUserInteractionEnabled = true
        cat6.isUserInteractionEnabled = true
        cat7.isUserInteractionEnabled = true
        cat8.isUserInteractionEnabled = true
        cat9.isUserInteractionEnabled = true
        
        
        let rec1 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        let rec2 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        let rec3 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        let rec4 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        let rec5 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        let rec6 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        let rec7 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        let rec8 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        let rec9 = UITapGestureRecognizer(target: self, action: #selector(scoreClick))
        
        cat1.addGestureRecognizer(rec1)
        cat2.addGestureRecognizer(rec2)
        cat3.addGestureRecognizer(rec3)
        cat4.addGestureRecognizer(rec4)
        cat5.addGestureRecognizer(rec5)
        cat6.addGestureRecognizer(rec6)
        cat7.addGestureRecognizer(rec7)
        cat8.addGestureRecognizer(rec8)
        cat9.addGestureRecognizer(rec9)
        
        // Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeCount), userInfo:  nil , repeats: true)
        // hide Timer
        timerHide = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(randomImg), userInfo: nil, repeats: true)
        randomImg()
    }
        
        
    
    @objc func randomImg(){
        imgArray = [cat1,cat2,cat3,cat4,cat5,cat6,cat7,cat8,cat9]
        for c in imgArray {
            c.isHidden = true // imageView closed
        }
        let random = Int(arc4random_uniform(UInt32(imgArray.count-1))) // random imageView opened
        imgArray[random].isHidden = false
    }
    
    
    @objc func scoreClick(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func timeCount(){
        count -= 1
        timeLabel.text = String(count)
        
        if count == 0 {
            timer.invalidate() // time's over
            timerHide.invalidate()// img is not view
            for c in imgArray {
                c.isHidden = true // imageView closed
            }
            
            // highScore check
            if highscore < score {
                highscore = score
                highscoreLabel.text = "HighScore : \(highscore)"
                UserDefaults.standard.set( highscore, forKey: "highscore") // highScore save
            }
            
            // Alert
            let alert = UIAlertController(title: "Time's Over!", message:"Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.count = 20
                self.timeLabel.text = String(self.count)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCount), userInfo:  nil , repeats: true)
                // hide Timer
                self.timerHide = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.randomImg), userInfo: nil, repeats: true)
        
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
    }
}
