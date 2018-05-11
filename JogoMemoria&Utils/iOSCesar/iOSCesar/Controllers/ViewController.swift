//
//  ViewController.swift
//  iOSCesar
//
//  Created by Marlon Chalegre on 13/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: MemoryGame!
    var emoticonDict: [Int:String]!
    var emoticons: [String]!
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var jogadasLabel: UILabel!
    
    override func viewDidLoad() {
        initGame()
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
        updateGameScreen()
    }
    
    
    // ------------
    // domain funcs
    
    func initGame() {
        self.emoticonDict = [Int:String]()
        self.emoticons = ["👻", "🎃", "💀", "😈", "😱", "🦇", "🕷", "🤡", "🕸", "🦉"]
        self.game = MemoryGame(numberOfPairs: (cardButtons.count/2))
        embaralharCards()
    }
    
    func embaralharCards() {
        let qtdEmbaralhamentos = self.cardButtons.count / 2
        for _ in 0..<qtdEmbaralhamentos {
            let randomIndex = Int(arc4random_uniform(UInt32(self.cardButtons.count)))
            self.cardButtons.append(self.cardButtons.remove(at: randomIndex))
        }
    }
    
    func resetGame() {
        initGame()
        self.updateGameScreen()
    }
    
    func updateGameScreen() {
        var cards = game.cards
        for index in cardButtons.indices {
            if cards[index].isUp {
                virarCard(cardButton: cardButtons[index], card: cards[index])
            } else {
                desvirarCard(cardButton: cardButtons[index], card: cards[index])
            }
        }
        
        // atualiza na tela a pontuacao do jogador
        jogadasLabel.text = "Pontuacao: \(game.pontuacao)"
        
        // verifica se o game acabou para fazer os ajustes na tela de finalizacao
        if game.fimDoJogo {
            finalizarJogo()
        }
    }
    
    func finalizarJogo() {
        // vira todas as cartas..
        var cards = game.cards
        for index in cardButtons.indices {
            virarCard(cardButton: cardButtons[index], card: cards[index])
        }
        
        // exibir alerte de fim de jogo..
        exibirAlertDeFimDeJogo()
    }
    
    func exibirAlertDeFimDeJogo() {
        let alert = UIAlertController(title: "Parabens voce ganhou!", message: "Deseja recomecar o jogo?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action) in
            self.resetGame()
        }))
        
        alert.addAction(UIAlertAction(title: "Nao", style: .cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    func virarCard(cardButton: UIButton, card: Card) {
        cardButton.setTitle(selectEmoticon(for: card.indentifier), for: .normal)
        cardButton.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        cardButton.isEnabled = false
    }
    
    func desvirarCard(cardButton: UIButton, card: Card) {
        cardButton.setTitle("", for: .normal)
        cardButton.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        cardButton.isEnabled = card.isMatched ? false : true
    }
    
    func selectEmoticon(for id: Int) -> String {
        if emoticonDict[id] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emoticons.count)))
            emoticonDict[id] = emoticons.remove(at: randomIndex)
        }
        return emoticonDict[id]!
    }
}

