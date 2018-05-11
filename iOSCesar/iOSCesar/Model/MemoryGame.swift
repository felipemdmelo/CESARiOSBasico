//
//  MemoryGame.swift
//  iOSCesar
//
//  Created by Aluno on 14/04/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import Foundation

class MemoryGame {
    
    var cards = [Card]()
    
    init(numberOfPairs: Int) {
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
    }
    
    func chooseCard(at index: Int) {
        let cardsUp = cards.indices.filter({ cards[$0].isUp })
        let currentUpCardIndex = cardsUp.count == 1 ? cardsUp.first : nil
        
        if !cards[index].isMatched {
            if let matchIndex = currentUpCardIndex {
                if matchIndex != index &&
                    cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = false
                }
            }
        }
    }
    
}
