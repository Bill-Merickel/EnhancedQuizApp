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
let question5 = Trivia(question: "What was the first mouse made of?", answer1: Answer(answer: "steel", correct: false), answer2: Answer(answer: "rubber", correct: false), answer3: Answer(answer: "plastic", correct: false), answer4: Answer(answer: "wood", correct: true))
let question6 = Trivia(question: "What came first?", answer1: Answer(answer: "Email", correct: true), answer2: Answer(answer: "The Internet", correct: false), answer3: Answer(answer: "WWW3", correct: false), answer4: Answer(answer: "Word processor", correct: false))
let question7 = Trivia(question: "Which company didn't start in a garage?", answer1: Answer(answer: "Apple", correct: false), answer2: Answer(answer: "Dell", correct: true), answer3: Answer(answer: "HP", correct: false), answer4: Answer(answer: "Microsoft", correct: false))
let question8 = Trivia(question: "When was YouTube created?", answer1: Answer(answer: "2002", correct: false), answer2: Answer(answer: "2003", correct: false), answer3: Answer(answer: "2005", correct: true), answer4: Answer(answer: "2008", correct: false))
let question9 = Trivia(question: "How many devices are currently linked to the Interent?", answer1: Answer(answer: "1M", correct: false), answer2: Answer(answer: "100M", correct: false), answer3: Answer(answer: "3B", correct: false), answer4: Answer(answer: "17B", correct: true))
let question10 = Trivia(question: "How man computer viruses are released each month?", answer1: Answer(answer: "100", correct: false), answer2: Answer(answer: "1800", correct: false), answer3: Answer(answer: "3700", correct: false), answer4: Answer(answer: "6400", correct: true))


var trivia = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]

let triviaSet = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]