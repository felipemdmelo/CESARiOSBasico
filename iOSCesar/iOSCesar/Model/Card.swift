//
//  Card.swift
//  iOSCesar
//
//  Created by Aluno on 14/04/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import Foundation

struct Card {
    
    var identifier: Int
    var isUp = false
    var isMatched = false
    
    static var lastId = -1
    
    static func getNextId() -> Int {
        lastId += 1
        return lastId
    }
    
    init() {
        self.identifier = Card.getNextId()
    }
    
}
