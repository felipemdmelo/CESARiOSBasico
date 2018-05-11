//
//  ViewController.swift
//  iOSCesar
//
//  Created by Aluno on 13/04/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // ? - estou avisando a quem for usar minha variavel que ela pode estar nula
    // ! - estou avisando a quem for usar minha variavel que eh garantido nao estar nula
    var game: MemoryGame!
    var emoticonDict = [Int:String]()
    var emoticons = [""] // escrever 10
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        game = MemoryGame(numberOfPairs: (cardButtons.count / 2))
    }
    
    func updateGameScreen() {
        var cards = game.cards
        for index in cardButtons.indices {
            if cards[index].isUp {
                cardButtons[index].setTitle(selectEmoticon(for: cards[index].identifier), for: .normal)
                cardButtons[index].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cardButtons[index].isEnabled = false
            } else {
                cardButtons[index].setTitle("", for: .normal)
                cardButtons[index].backgroundColor = cards[index].isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.1684893477, green: 0.1876109372, blue: 1, alpha: 1)
                cardButtons[index].isEnabled = !cards[index].isMatched
            }
        }
    }
    
    @IBAction func selectCard(_ sender: UIButton) {
        var position = 0
        for i in cardButtons.indices {
            if sender == cardButtons[i] {
                position = i
                break
            }
        }
        game.chooseCard(at: position)
    }
    
    func selectEmoticon(for id: Int) -> String {
        if emoticonDict[id] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emoticons.count)))
            emoticonDict[id] = emoticons.remove(at: randomIndex)
        }
        return emoticonDict[id]!
    }
    
}

