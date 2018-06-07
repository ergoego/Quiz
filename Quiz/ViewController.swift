//
//  ViewController.swift
//  Quiz
//
//  Created by Erik Olson on 4/18/17.
//  Copyright © 2017 Erik Olson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?",
                               "What is 7+7?",
                               "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes",
                             "14",
                             "Montpelier"]
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentQuestionLabel.alpha = 1
        nextQuestionLabel.alpha = 0
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        
        currentQuestionLabel.text = nextQuestionLabel.text
        
        animateFadeOut()
        
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateFadeIn()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
        
    }
    
    func animateFadeIn() {
            nextQuestionLabel.alpha = 0
            UIView.animate(withDuration: 1.0, animations: {self.nextQuestionLabel.alpha = 1})
    }
    func animateFadeOut() {
        currentQuestionLabel.alpha = 1
        UIView.animate(withDuration: 1.0, animations: {self.currentQuestionLabel.alpha = 0})
    }
}

