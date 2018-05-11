//
//  Compra.swift
//  HelloKituraPackageDescription
//
//  Created by Telmo Mota on 17/03/18.
//

import Foundation

public class Compra {
    var id: Int?
    var descricao: String = ""
    var quantidade: Float = 0
    var tags: [String]?
    var data: String = ""
    var valor: Float = 0
    
    init?(json: [String:Any]) {
        if let descricao = json["descricao"] as? String,
            let quantidade = json["quantidade"] as? Float,
            let data = json["data"] as? String,
            let valor = json["valor"] as? Float,
            let tags =  json["tags"] as? [String] {
            
            self.descricao = descricao
            self.quantidade = quantidade
            self.data = data
            self.tags = tags
            self.valor = valor
        }
    }
    
    func asMap() -> [String:Any] {
        var map: [String:Any] = [:]
        
        map["id"] = id
        map["descricao"] = descricao
        map["quantidade"] = quantidade
        map["tags"] = tags
        map["data"] = data
        map["valor"] = valor
        
        return map
    }
}

