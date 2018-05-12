//
//  StringRepository.swift
//  TableView
//
//  Created by Aluno on 12/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import Foundation

class StringRepository {
    
    var listOfStrings = ["Something 1", "Something 2", "Something 3"]
    
    private static var singleton: StringRepository?
    static var instance: StringRepository {
        get {
            if singleton == nil {
                singleton = StringRepository()
            }
            return singleton!
        }
    }
    
    func size() -> Int {
        return listOfStrings.count
    }
    
    func insert(value: String) {
        listOfStrings.append(value)
    }
    
    func remove(at index: Int) -> String {
        return listOfStrings.remove(at: index)
    }
    
    func get(at index: Int) -> String {
        return listOfStrings[index]
    }
}
