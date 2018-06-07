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
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
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
        
        updateOffScreenLabelPosition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0 // Set the next question to invisible
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        
        currentQuestionIndex += 1 // increment the current question to next index. If this would cause the array to go out of bounds, loop back around to the first question at questions[0]
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex] // remember, let does not allow you to change the reference, but allows you to change what is in that reference. In this case, we can let question equal the same, constant array of questions, but the index in questions can change and the compiler will allow that.
        
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
        
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded() // resolve outstanding layout changes right before animation occurs. If we do not call this before the rest of the method, we will get some perhaps unintended consequences. In this case, we will also animate the size of the labels, so we will see the labels animate their re-sizing. You can see this happen if you delete this method call on view and run this app in the simulator with animations slowed (Command-T). The labels will animate their re-sizing. Not noticeable at full speed, but an unintended side-effect none-the-less that could muck up a more complex animation if not careful.
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 0.5,
                       animations: {
                            self.currentQuestionLabel.alpha = 0
                            self.nextQuestionLabel.alpha = 1
                        
                            self.view.layoutIfNeeded()
                        },
                       completion: { _ in
                            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                        
                            swap(&self.nextQuestionLabelCenterXConstraint, &self.currentQuestionLabelCenterXConstraint)
                        
                            self.updateOffScreenLabelPosition() // need to call this method to set the off-screen label to be left of the screen (-screenWidth), otherwise the current and next question will get swapped, but the off-screen label will still be to the right of the screen and then our animation will go in and out of the right side of the screen instead of across from right to left. changed the name of this method to updateOffScreenLabelPosition to indicate that the position is what is important here.
                        
                        })
    }
    func updateOffScreenLabelPosition() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
}

