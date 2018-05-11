//
//  MemoryGame.swift
//  iOSCesar
//
//  Created by Marlon Chalegre on 14/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import Foundation

class MemoryGame {
    
    var pontuacao = 0
    var fimDoJogo = false
    var cards = [Card]()
    
    init(numberOfPairs: Int) {
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
    }
    
    // metodo para escolha de novo card
    func chooseCard(at index: Int) {
        // filtra da lista completa de cards, apenas os indices dos cards que estao up
        let cardsUp = cards.indices.filter({ cards[$0].isUp })
        // armazena na constante o indice da primeira carta up, caso exista
        let currentUpCardIndex = cardsUp.count == 1 ? cardsUp.first : nil
        
        // verifica se o card escolhido ainda nao fez match com nenhum outro card
        if !cards[index].isMatched {
            // verifica se currentUpCardIndex esta diferente de nulo e pode ser atribuido para match index
            // se currentUpCardIndex eh diferente de nil, significa que ja existia um card up antes da escolha do proximo card
            if let matchIndex = currentUpCardIndex {
                // verifica se o card up eh diferente do card escolhido
                // e se o identificador eh igual, caracterizando cards iguais
                if matchIndex != index && cards[matchIndex].indentifier == cards[index].indentifier {
                    // atribui true para a propertie isMatched para o card up
                    // e para o card escolhido
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // adiciona pontos pelo match
                    pontuacaoMatchedCards()
                    
                    // filtra cards que nao estao matched
                    // caso nao encontre nenhum, eh pq todos estaos matched
                    // e assim pode finalizar o jogo
                    let cardsMatched = cards.indices.filter({ !cards[$0].isMatched })
                    if cardsMatched.count == 0 {
                        self.fimDoJogo = true
                    }
                    
                } else {
                    // retira pontos pelo nao match
                    pontuacaoNonMatchedcards()
                }
                // torna a carta escolhida up
                cards[index].isUp = true
            } else { // nao havia nenhum card up
                for i in cards.indices { // este loop vira up o card escolhido no index
                    cards[i].isUp = (i == index)
                }
            }
        }
    }
    
    func pontuacaoMatchedCards() {
        self.pontuacao += 2
    }
    
    func pontuacaoNonMatchedcards() {
        self.pontuacao -= 1
    }
}
