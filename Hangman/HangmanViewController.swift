//
//  HangmanViewController.swift
//  Hangman
//
//  Created by Jun Keun Yi on 2/16/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    let alertControllerWin = UIAlertController(title: "Hoorah", message: "You saved Mr. Burnbeer. Would you like to start a New Game?", preferredStyle: .alert)
    let alertControllerLose = UIAlertController(title: "Game Over!", message: "Aww, too bad. Would you like to start a New Game?", preferredStyle: .alert)
    let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in }
    
    
    
    var currentMan: Hangman?
    var targetWord: String?
    var currentWord: String = ""
    var wordArray: [Character]?
    var guess: Character?
    var guessArray: [Character]?
    var guesses: [Character]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in self.initializeGame()}
        alertControllerWin.addAction(actionOK)
        alertControllerLose.addAction(actionOK)
        
        initializeGame()
    }

    func initializeGame() {
        guess = nil
        GuessField.text = ""
        guesses = ["*"]
        IncorrectLetters.text = "Wrong!: "
        currentStack.text = "Save Mr.Burnbeer from his hanging!"
        currentMan = Hangman()
        targetWord = currentMan!.word
        wordArray = wordToArray(word: targetWord!)
        currentWord = ""
        makeInitialCurrentWord()
        guessArray = wordToArray(word: currentWord)
        print(targetWord ?? "none")
        print(currentWord)
        print(wordArray!)
        updateHangmanImage()
        
    }
    @IBOutlet weak var IncorrectLetters: UILabel!
    
    @IBOutlet weak var currentStack: UILabel!
    
    @IBOutlet weak var hangmanImage: UIImageView!
    
    @IBOutlet weak var GuessField: UITextField!
    
    func updateCurrentGuess() {
        var input = GuessField.text!.uppercased()
        if input != "" {
            guess = input.removeFirst()
        }
    }
    
    
    @IBAction func restrictingInputLength(_ sender: UITextField) {
        var currentText: String
        if let textInput = GuessField.text {
            if textInput.count > 1 {
                currentText = textInput
                GuessField.text = String(currentText.removeFirst())
            }
            updateCurrentGuess()
        }
    }
    
    @IBAction func checkCorrectChar(_ sender: UIButton) {
        if guess != nil {
            if guesses!.contains(guess!) {
                GuessField.text = ""
                guess = nil
            } else {
                var testArray = guessArray!
                for index in 0..<wordArray!.count {
                    if wordArray![index] == guess {
                        testArray[index] = guess!
                    }
                }
                guesses!.append(guess!)
                GuessField.text = ""
                if testArray != guessArray! {
                    return updateCurrentWordAndStack(newWordArray: testArray)
                } else {
                        return updateWrongAnswer(wrongGuess: guess!)
                }
            }
        }
    }
    
    func updateCurrentWordAndStack(newWordArray: [Character]) {
        guessArray = newWordArray
        currentWord = arrayToWord(array: guessArray!)
        currentStack.text = currentWord
        checkForGameWin()
    }
    
    func checkForGameWin() {
        if currentStack.text == targetWord {
            self.present(alertControllerWin, animated: true, completion: nil)
            guess = nil
        }
    }
 
    
    
    
    func updateWrongAnswer(wrongGuess: Character) {
        currentMan!.reduceHealth()
        updateHangmanImage()
        if (currentMan!.checkForEnd()) {
            self.present(alertControllerLose, animated: true, completion: nil)
        }
        else {
            if IncorrectLetters.text == "Wrong!: " {
                IncorrectLetters.text! += String(wrongGuess)
            } else {
                IncorrectLetters.text! += ", " + String(wrongGuess)
            }
            guesses!.append(wrongGuess)
        }
        guess = nil
    }
    
    
    
    func updateHangmanImage() {
        hangmanImage.image = currentMan?.getHangman(status: (currentMan?.health)!)
    }
    
    func makeInitialCurrentWord() {
        for index in 0..<wordArray!.count {
            if wordArray![index] == " " {
                currentWord += " "
            } else {
                currentWord += "-"
            }
        }
    }
    
    func wordToArray(word: String) -> [Character] {
        var checkingWord = word
        var returnArray: [Character] = []
        for _ in 0..<checkingWord.count {
            returnArray.append(checkingWord.removeFirst())
        }
        return returnArray
    }
    
    func arrayToWord(array: [Character]) -> String {
        var returnString = ""
        for index in 0..<array.count {
            returnString.append(array[index])
        }
        return returnString
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
