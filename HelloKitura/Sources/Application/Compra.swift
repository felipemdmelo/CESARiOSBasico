//
//  Compra.swift
//  HelloKituraPackageDescription
//
//  Created by Aluno on 17/03/18.
//

import Foundation

protocol Vendavel {
    func asMap() -> [String:Any]
}

enum TipoCompra {
    case recorrente
    case unica
}

enum CompraErros: Error {
    case idInvalido
    case precoInvalido
    case valorAusente
}

public class Compra: Vendavel {
    var id: Int?
    var produto: Produto
    var quantidade: Float = 0
    var tags: [String]?
    var data: String = ""
    var valor: Float = 0
    var json: [String:Any] {
        get {
            return self.json
        }
    }
    var tipoCompra: TipoCompra
    
    init(descricao: String, _ quantidade: Float, _ tags: [String]?, _ data: String, valor: Float, tipoCompra: TipoCompra) throws {
        if valor < 0 {
            throw CompraErros.precoInvalido
        }
        
        if quantidade < 0 {
            throw CompraErros.valorAusente
        }
        
        self.produto = Produto(descricao)
        self.quantidade = quantidade
        self.tags = tags
        self.data = data
        self.valor = valor
        self.tipoCompra = tipoCompra
    }
    
    convenience init?(json: [String:Any]) throws {
        var tipoCompra: TipoCompra
        switch json["tipoCompra"] as! String {
        case "recorrente":
            tipoCompra = TipoCompra.recorrente
        default:
            tipoCompra = TipoCompra.unica
        }
        try self.init(descricao: json["descricao"] as! String,
                  json["quantidade"] as! Float,
                  json["tags"] as? [String],
                  json["data"] as! String,
                  valor: json["valor"] as! Float,
                  tipoCompra: tipoCompra)
    }
    
    func asMap() -> [String:Any] {
        var rtn: [String:Any] = [:]
        
        rtn["id"] = id
        rtn["descricao"] = produto.descricao
        rtn["quantidade"] = quantidade
        rtn["tags"] = tags
        rtn["data"] = data
        rtn["valor"] = valor
        rtn["tipoCompra"] = String(describing: tipoCompra)
        
        return rtn
    }
}

public class Produto {
    var id: Int?
    var descricao: String = ""
    var tags: [String]?
    
    init(_ descricao: String) {
        self.descricao = descricao
    }
}

public class Cliente {
    var id: Int?
    var nome: String = ""
    var tags: [String]?
    
    init(_ nome: String) {
        self.nome = nome
    }
}

public class Venda: Vendavel {
    var id: Int?
    var produto: Produto
    var cliente: Cliente
    var quantidade: Float = 0
    var tags: [String]?
    var data: String = ""
    var valor: Float = 0
    var json: [String:Any] {
        get {
            return self.json
        }
    }
    var tipoCompra: TipoCompra
    
    init(descricao: String, _ quantidade: Float, _ tags: [String]?, _ data: String, valor: Float, tipoCompra: TipoCompra, nomeCliente: String) throws {
        if valor < 0 {
            throw CompraErros.precoInvalido
        }
        
        if quantidade < 0 {
            throw CompraErros.valorAusente
        }
        
        self.produto = Produto(descricao)
        self.quantidade = quantidade
        self.tags = tags
        self.data = data
        self.valor = valor
        self.tipoCompra = tipoCompra
        self.cliente = Cliente(nomeCliente)
    }
    
    convenience init?(json: [String:Any]) throws {
        var tipoCompra: TipoCompra
        switch json["tipoCompra"] as! String {
        case "recorrente":
            tipoCompra = TipoCompra.recorrente
        default:
            tipoCompra = TipoCompra.unica
        }
        try self.init(descricao: json["descricao"] as! String,
                      json["quantidade"] as! Float,
                      json["tags"] as? [String],
                      json["data"] as! String,
                      valor: json["valor"] as! Float,
                      tipoCompra: tipoCompra,
                      nomeCliente: json["nomeCliente"] as! String)
    }
    
    func asMap() -> [String:Any] {
        var rtn: [String:Any] = [:]
        
        rtn["id"] = id
        rtn["descricao"] = produto.descricao
        rtn["quantidade"] = quantidade
        rtn["tags"] = tags
        rtn["data"] = data
        rtn["valor"] = valor
        rtn["tipoCompra"] = String(describing: tipoCompra)
        rtn["nomeCliente"] = cliente.nome
        
        return rtn
    }
}
