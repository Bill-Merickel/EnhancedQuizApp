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
    
    // Game Mechanics
    let questionsPerRound = trivia.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var correctAnswer = ""
    
    // Timer Mechanics
    var timer = NSTimer()
    var counter: NSTimeInterval = 15
    var timeLeft = 15
    var counterRunning = false
    
    // Game Sounds
    var trueSound: SystemSoundID = 0
    var falseSound: SystemSoundID = 1
    
    // Connections to View
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // Start the app
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameTrueSound()
        loadGameFalseSound()
        appStart()
        displayQuestion()
        button1.layer.cornerRadius = 15
        button2.layer.cornerRadius = 15
        button3.layer.cornerRadius = 15
        button4.layer.cornerRadius = 15
        playAgainButton.layer.cornerRadius = 15
        
        // Enable portrait mode only.
        func shouldAutorotate() -> Bool {
            return false
        }
        
        func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
            return UIInterfaceOrientationMask.Portrait
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare app UI for first question.
    func appStart() {
        questionField.hidden = true
        countingLabel.hidden = true
        checkLabel.hidden = true
        hideButtons()
        playAgainButton.hidden = true
    }
    
    func displayQuestion() {
        
        // Pick a random question
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(trivia.count)
        let questionDictionary = trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        
        // Begin the timer
        countingLabel.text = "15"
        resetTimer()
        beginTimer()
        
        // Set up buttons
        button1.setTitle(questionDictionary.answer1.answer, forState: UIControlState.Normal)
        button2.setTitle(questionDictionary.answer2.answer, forState: UIControlState.Normal)
        button3.setTitle(questionDictionary.answer3.answer, forState: UIControlState.Normal)
        button4.setTitle(questionDictionary.answer4.answer, forState: UIControlState.Normal)

        checkLabel.hidden = true
        playAgainButton.hidden = true
        questionField.hidden = false
        countingLabel.hidden = false
        showButtons()
        enableButtons()
        
        // If the timer reaches 0...
        if counter == 0.0 {
            
            // Mark answer as wrong and move to next question
            questionsAsked += 1
            trivia.removeAtIndex(indexOfSelectedQuestion)
            disableButtons()
            checkLabel.hidden = false
            playGameFalseSound()
            checkLabel.text = "You ran out of time."
            checkLabel.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            timer.invalidate()
        }
    }
    
    func displayScore() {
        // Hide the answer buttons, show score and button to play again.
        countingLabel.hidden = true
        checkLabel.hidden = true
        hideButtons()
        playAgainButton.hidden = false
        
        // Congratulate or show disappointment
        if correctQuestions >= 7 {
            questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        } else {
            questionField.text = "Bummer.\nYou got \(correctQuestions) out of \(questionsPerRound) correct."
        }
    }
    
    // When an answer is selected...
    @IBAction func checkAnswer(sender: UIButton) {
        
        showRightAnswer()
        counterRunning = false
        
        // If the answer is right...
        if sender.titleLabel!.text == correctAnswer {
            // Stop timer and play the Correct sound
            correctQuestions += 1
            checkLabel.hidden = false
            playGameTrueSound()
            checkLabel.text = "Correct!"
            checkLabel.textColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
            timer.invalidate()
        } else {
            // Stop timer and play the Incorrect sound
            checkLabel.hidden = false
            playGameFalseSound()
            checkLabel.text = "Sorry, wrong answer."
            checkLabel.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            timer.invalidate()
        }
        
        // Remove the question from the list of questions, load the next round in 3 seconds.
        questionsAsked += 1
        trivia.removeAtIndex(indexOfSelectedQuestion)
        disableButtons()
        loadNextRoundWithDelay(seconds: 3)
    }
    
    // If all questions have been asked...
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    
    // This function showcases the right answer.
    func showRightAnswer() {
        
        // This decides which button has the right answer.
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
        
        // This shows the correct button and hides all others.
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
    }
    
    // Start the timer
    func beginTimer() {
        if counterRunning == false {
            timeLeft = 15
            counter = 15
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
            counterRunning = true
        }
    }
    
    // Update the timer label every second
    func updateCounter() {
        timeLeft -= 1
        countingLabel.text = "\(timeLeft)"
        
        // If you ran out of time...
        if timeLeft == 0 {
            
            // Move on to the next question
            timer.invalidate()
            checkLabel.hidden = false
            checkLabel.text = "Sorry, you ran out of time!"
            checkLabel.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            questionsAsked += 1
            playGameFalseSound()
            loadNextRoundWithDelay(seconds: 3)
            trivia.removeAtIndex(indexOfSelectedQuestion)
        }
    }
    
    // Reset the timer
    func resetTimer() {
        counter = 15
        timeLeft = 15
        counterRunning = false
        beginTimer()
    }
    
    // Enable buttons
    func enableButtons() {
        button1.enabled = true
        button2.enabled = true
        button3.enabled = true
        button4.enabled = true
    }
    
    // Disable buttons
    func disableButtons() {
        button1.enabled = false
        button2.enabled = false
        button3.enabled = false
        button4.enabled = false
    }
    
    // Show buttons
    func showButtons() {
        button1.hidden = false
        button2.hidden = false
        button3.hidden = false
        button4.hidden = false
    }
    
    // Hide buttons
    func hideButtons() {
        button1.hidden = true
        button2.hidden = true
        button3.hidden = true
        button4.hidden = true
    }
    
    // Reset the question set
    func restoreQuestions() {
        for questions in triviaSet {
            trivia.append(questions)
        }
    }
    
    // Start a new round
    @IBAction func playAgain() {
        // Show the answer buttons

        questionsAsked = 0
        correctQuestions = 0
        restoreQuestions()
        displayQuestion()
        showButtons()
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
    
    // Correct Game Sound
    func loadGameTrueSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &trueSound)
    }
    
    func playGameTrueSound() {
        AudioServicesPlaySystemSound(trueSound)
    }
    
    // Incorrect Game SOund
    func loadGameFalseSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Sad_Trombone-Joe_Lamb-665429450", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &falseSound)
    }
    
    func playGameFalseSound() {
        AudioServicesPlaySystemSound(falseSound)
    }
}