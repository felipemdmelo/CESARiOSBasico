//
//  TransacaoModel.swift
//  ProjetoiOSBasico
//
//  Created by Aluno on 12/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import Foundation

public class TransacaoModel {
    
    var valor = 0
    
    var descricao: String {
        get {
            if valor < 0 {
                return "Saque R$ \(valor),00"
            }
            return "Deposito R$ \(valor),00"
        }
    }
    
    var ehNegativo: Bool {
        get {
            if valor < 0 {
                return true
            }
            return false
        }
    }
    
}
