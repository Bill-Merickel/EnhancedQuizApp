//
//  TriviaModel.swift
//  TrueFalseStarter
//
//  Created by Bill Merickel on 6/30/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//


struct Answer {
    let answer: String
    let correct: Bool
}

struct Trivia {
    let question: String
    let answer1: Answer
    let answer2: Answer
    let answer3: Answer
    let answer4: Answer
}

let question1 = Trivia(question: "Is Treehouse the coolest thing ever?", answer1: Answer(answer: "Kind of", correct: false), answer2: Answer(answer: "Not really", correct: false), answer3: Answer(answer: "Absolutely!", correct: true), answer4: Answer(answer: "No", correct: false))
let question2 = Trivia(question: "What language(s) can iOS apps be developed in?", answer1: Answer(answer: "Java", correct: false), answer2: Answer(answer: "Swift and Objective-C", correct: true), answer3: Answer(answer: "HTML and CSS", correct: false), answer4: Answer(answer: "Javascript", correct: false))
let question3 = Trivia(question: "What year did XCode come out in?", answer1: Answer(answer: "2001", correct: false), answer2: Answer(answer: "2003", correct: true), answer3: Answer(answer: "2006", correct: false), answer4: Answer(answer: "2008", correct: false))
let question4 = Trivia(question: "How many iPhones are there currently?", answer1: Answer(answer: "5", correct: false), answer2: Answer(answer: "10", correct: false), answer3: Answer(answer: "13", correct: true), answer4: Answer(answer: "16", correct: false))

var trivia = [question1, question2, question3, question4]

let triviaSet = [question1, question2, question3, question4]