//
//  ViewController.swift
//  X-O
//
//  Created by Hussain Ashkanani on 6/29/20.
//  Copyright © 2020 Hussain02. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var XscoreLabel: UILabel!
    @IBOutlet weak var OscoreLabel: UILabel!
    
    // تشغيل موسيقى
    var BackgroundSound: AVAudioPlayer?
    var FunnySound1: AVAudioPlayer?
    var FunnySound2: AVAudioPlayer?
    
    func playSound() {
    let path = Bundle.main.path(forResource: "Happy Video Game Music ).mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)

    do {
        BackgroundSound = try AVAudioPlayer(contentsOf: url)
        BackgroundSound?.play()
    } catch {
        // couldn't load file :(
    }
    }
    func playFunnySound1() {
        let path = Bundle.main.path(forResource: "Cartoon Taunt - Sound Effect for Editing.mp3", ofType:nil)!
           let url = URL(fileURLWithPath: path)

           do {
               FunnySound1 = try AVAudioPlayer(contentsOf: url)
               FunnySound1?.play()
           } catch {
               // couldn't load file :(
           }
        
    }
    func playFunnySound2() {
           let path = Bundle.main.path(forResource: "Party Horn Sound Effect.mp3", ofType:nil)!
              let url = URL(fileURLWithPath: path)

              do {
                  FunnySound2 = try AVAudioPlayer(contentsOf: url)
                  FunnySound2?.play()
              } catch {
                  // couldn't load file :(
              }
           
       }
    
    // نضع هذه الجملة خارج الدالة ، لأن الدالة تعيد تشغيل نفسها في كل كرة نضغط على الزر و بالتالي لن تزداد قيمة الكاونتر
    var counter = 0
    var BGcounter = 0
    var buttons: [UIButton] = []
   
    
    override func viewDidLoad() {
        buttons = [b1,b2,b3,b4,b5,b6,b7,b8,b9]
        playSound()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x2.png")!)
    }

    
    
    @IBAction func press(_ sender: UIButton) {
        
        
        
        print ("تم الضغط عليي !")
        if counter % 2 == 0 {
            playFunnySound1()
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.green, for: .normal)
            turnLabel.text = "O turn"
           AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        else {
            playFunnySound2()
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.red, for: .normal)
            turnLabel.text = "X turn"
             AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        
        
        counter += 1
        // اذا اردنا منع الزر من التفاعل مرة اخرى بعد ضغطه ، نكتب هذا الكود 👇🏼
        sender.isEnabled = false
        
        
        if Winning(winner: "X") {
            okAlert(title: "X Wins!", message: "مبرووووك X 😍")
        }
            
        else if  Winning(winner: "O") {
            okAlert(title: "O Wins!", message: "مبرووووك O 😍")
        }
        else if counter == 9 {
            okAlert(title: "no one wins", message: "play again")
        }
    }
    
    @IBAction func resetTapped() {
        restartGame()
 
        if (BGcounter == 0){
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x3.png")!)
            BGcounter += 1
        }else if (BGcounter == 1){
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x4.png")!)
            BGcounter += 1
        }else if (BGcounter == 2){
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x2.png")!)
            BGcounter = 0
        }
        
       
    }
    
    
    func Winning(winner: String) -> Bool
    {
        // الزر بداخله ليبل بداخله نص ، فتكتب بهذه الطريقة
        //  winning
        if  (b1.titleLabel?.text == winner && b2.titleLabel?.text == winner && b3.titleLabel?.text == winner) ||
            (b4.titleLabel?.text == winner && b5.titleLabel?.text == winner && b6.titleLabel?.text == winner) ||
            (b7.titleLabel?.text == winner && b8.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b1.titleLabel?.text == winner && b4.titleLabel?.text == winner && b7.titleLabel?.text == winner) ||
            (b2.titleLabel?.text == winner && b5.titleLabel?.text == winner && b8.titleLabel?.text == winner) ||
            (b3.titleLabel?.text == winner && b6.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b1.titleLabel?.text == winner && b5.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b3.titleLabel?.text == winner && b5.titleLabel?.text == winner && b7.titleLabel?.text == winner)
        {
            if winner == "X" {
                var score : Int = Int(XscoreLabel.text!)!
                score += 1
                XscoreLabel.text = "\(score)"
            }
            else if winner == "O" {
                var score : Int = Int(OscoreLabel.text!)!
                score += 1
                OscoreLabel.text = "\(score)"
               
                              
            }
        
                
        
            
            
            
            print ("\(winner) الفائز")
            
            let alertController = UIAlertController(title: "\(winner) فاز", message: "قم بالضغط على الزر التالي ليتم إعادة اللعب", preferredStyle: .alert)
            // يجب كتابة سيلف في السطر التالي لانه بين اقواس مجعدة ، ستفهم التفاصيل لاحقا
            let restartAction = UIAlertAction(title: "إعادة اللعب", style: .cancel) { (alert) in
                self.restartGame()
            }
            alertController.addAction(restartAction)
            present(alertController, animated: true, completion: nil)
            if (BGcounter == 0){
                     self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x3.png")!)
                     BGcounter += 1
                 }else if (BGcounter == 1){
                     self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x4.png")!)
                     BGcounter += 1
                 }else if (BGcounter == 2){
                     self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x2.png")!)
                     BGcounter = 0
                 }
        }
        if  (b1.titleLabel?.text == winner && b2.titleLabel?.text == winner && b3.titleLabel?.text == winner) ||
            (b4.titleLabel?.text == winner && b5.titleLabel?.text == winner && b6.titleLabel?.text == winner) ||
            (b7.titleLabel?.text == winner && b8.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b1.titleLabel?.text == winner && b4.titleLabel?.text == winner && b7.titleLabel?.text == winner) ||
            (b2.titleLabel?.text == winner && b5.titleLabel?.text == winner && b8.titleLabel?.text == winner) ||
            (b3.titleLabel?.text == winner && b6.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b1.titleLabel?.text == winner && b5.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b3.titleLabel?.text == winner && b5.titleLabel?.text == winner && b7.titleLabel?.text == winner)
        {
            return true
        }
        else {
            return false
        }
    }
    func restartGame() {
        for b in buttons {
            b.setTitle("", for: .normal)
            b.titleLabel?.text = ""
            b.isEnabled = true
            
        }
        
        counter = 0
        // الاكس دايما يبدي اول
        turnLabel.text = "X Turn"
    }
    func okAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "إعادة اللعب", style: .cancel) { (alert) in
            self.restartGame()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
        if (BGcounter == 0){
                 self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x3.png")!)
                 BGcounter += 1
             }else if (BGcounter == 1){
                 self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x4.png")!)
                 BGcounter += 1
             }else if (BGcounter == 2){
                 self.view.backgroundColor = UIColor(patternImage: UIImage(named: "x2.png")!)
                 BGcounter = 0
             }
    }
    
    
}

