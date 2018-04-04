//
//  HangmanGame.swift
//  Hangman
//
//  Created by Jun Keun Yi on 2/16/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import Foundation
import UIKit

class Hangman {

    let initialHealth: Int = 6

    /* The ongoing status of the Hangman
        Starting at initialHealth, if health
        reaches 0, the Hangman dies and
        the user loses the game
    */
    var health: Int
    var word: String
    
    init() {
        health = initialHealth
        word = HangmanPhrases().getRandomPhrase()
    }
    
    func reduceHealth() {
        health = health - 1
    }
    
    func checkForEnd() -> Bool {
        if health == 0 { return true }
        return false
    }
    
    func getHangman(status: Int) -> UIImage {
        return UIImage(named: "hangman" + String(status) + ".jpg")!
    }
    
}
