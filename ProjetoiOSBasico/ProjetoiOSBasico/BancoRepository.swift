//
//  BancoRepository.swift
//  ProjetoiOSBasico
//
//  Created by Aluno on 12/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import Foundation

public class BancoRepository {
    
    var list = [TransacaoModel]()
    
    private static var singleton: BancoRepository?
    
    static var instance: BancoRepository {
        get {
            if singleton == nil {
                singleton = BancoRepository()
            }
            return singleton!
        }
    }
    
    init() {
        let tranDeposito = TransacaoModel()
        tranDeposito.valor = 1000
        insert(value: tranDeposito)
        
        let tranSaque = TransacaoModel()
        tranSaque.valor = -450
        insert(value: tranSaque)
    }
    
    func size() -> Int {
        return list.count
    }
    
    func insert(value: TransacaoModel) {
        list.append(value)
    }
    
    func get(at index: Int) -> TransacaoModel {
        return list[index]
    }
    
    func saldoValor() -> Int {
        var rtn = 0
        for item in list {
            rtn += item.valor
        }
        
        return rtn
    }
    
    func saldoDescricao() -> String {
        return "Seu saldo e: R$ \(saldoValor()),00"
    }
    
}
