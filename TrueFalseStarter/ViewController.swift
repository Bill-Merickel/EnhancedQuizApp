//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import Foundation
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = trivia.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var correctAnswer = ""
    var timer = NSTimer()
    var counter = 15
    
    
    var trueSound: SystemSoundID = 0
    var falseSound: SystemSoundID = 1
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    func appStart() {
        questionField.hidden = true
        countingLabel.hidden = true
        checkLabel.hidden = true
        button1.hidden = true
        button2.hidden = true
        button3.hidden = true
        button4.hidden = true
        playAgainButton.hidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countingLabel.text = String(counter)
        loadGameTrueSound()
        loadGameFalseSound()
        // Start game
        appStart()
        displayQuestion()
        
        func startTimer() {
            countingLabel.text = String(counter)
            self.timer = NSTimer(timeInterval: 1, target: self, selector: Selector(updateCounter()), userInfo: nil, repeats: true)
        }
        
        func updateCounter() {
            while counter > 0 {
                countingLabel.text = String(self.counter--)
            }
        }
        
        startTimer()
        updateCounter()

        
        button1.layer.cornerRadius = 15
        button2.layer.cornerRadius = 15
        button3.layer.cornerRadius = 15
        button4.layer.cornerRadius = 15
        playAgainButton.layer.cornerRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(trivia.count)
        let questionDictionary = trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        
        button1.setTitle(questionDictionary.answer1.answer, forState: UIControlState.Normal)
        button2.setTitle(questionDictionary.answer2.answer, forState: UIControlState.Normal)
        button3.setTitle(questionDictionary.answer3.answer, forState: UIControlState.Normal)
        button4.setTitle(questionDictionary.answer4.answer, forState: UIControlState.Normal)

        checkLabel.hidden = true
        playAgainButton.hidden = true
        
        questionField.hidden = false
        countingLabel.hidden = false
        button1.hidden = false
        button2.hidden = false
        button3.hidden = false
        button4.hidden = false
        
        button1.enabled = true
        button2.enabled = true
        button3.enabled = true
        button4.enabled = true
        
    }
    
    func displayScore() {
        // Hide the answer buttons
        countingLabel.hidden = true
        checkLabel.hidden = true
        button1.hidden = true
        button2.hidden = true
        button3.hidden = true
        button4.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        if correctQuestions >= 3 {
            questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        } else {
            questionField.text = "Bummer.\nYou got \(correctQuestions) out of \(questionsPerRound) correct."
        }
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
        
        if selectedQuestionDict.answer1.correct == true {
            correctAnswer = selectedQuestionDict.answer1.answer
        } else if selectedQuestionDict.answer2.correct == true {
            correctAnswer = selectedQuestionDict.answer2.answer
        } else if selectedQuestionDict.answer3.correct == true {
            correctAnswer = selectedQuestionDict.answer3.answer
        } else if selectedQuestionDict.answer4.correct == true {
            correctAnswer = selectedQuestionDict.answer4.answer
        }
        
        if sender.titleLabel!.text == correctAnswer {
            correctQuestions += 1

            checkLabel.hidden = false
            playGameTrueSound()
            checkLabel.text = "Correct!"
            checkLabel.textColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        } else {
            checkLabel.hidden = false
            playGameFalseSound()
            checkLabel.text = "Sorry, wrong answer."
            checkLabel.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
        
        
        if selectedQuestionDict.answer1.correct == false {
            button1.hidden = true
        }
        if selectedQuestionDict.answer2.correct == false {
            button2.hidden = true
        }
        if selectedQuestionDict.answer3.correct == false {
            button3.hidden = true
        }
        if selectedQuestionDict.answer4.correct == false {
            button4.hidden = true
        }
        
        questionsAsked += 1
        
        trivia.removeAtIndex(indexOfSelectedQuestion)
        
        button1.enabled = false
        button2.enabled = false
        button3.enabled = false
        button4.enabled = false
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func startTimer() {
        countingLabel.text = String(counter)
        self.timer = NSTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        while counter > 0 {
            countingLabel.text = String(self.counter--)
        }
    }
    
    func timesUp(sender: UIButton) {
        checkAnswer(sender)
        self.timer.invalidate()
    }
    
    func restoreQuestions() {
        for questions in triviaSet {
            trivia.append(questions)
        }
    }
    
    
    @IBAction func playAgain() {
        // Show the answer buttons

        questionsAsked = 0
        correctQuestions = 0
        restoreQuestions()
        displayQuestion()
        
        button1.hidden = false
        button2.hidden = false
        button3.hidden = false
        button4.hidden = false
    }
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameTrueSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &trueSound)
    }
    
    func playGameTrueSound() {
        AudioServicesPlaySystemSound(trueSound)
    }
    
    func loadGameFalseSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Sad_Trombone-Joe_Lamb-665429450", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &falseSound)
    }
    
    func playGameFalseSound() {
        AudioServicesPlaySystemSound(falseSound)
    }
}