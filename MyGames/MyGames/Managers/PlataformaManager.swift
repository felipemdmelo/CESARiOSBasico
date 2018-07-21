//
//  PlataformaManager.swift
//  MyGames
//
//  Created by Aluno on 21/07/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import Foundation
import CoreData
class PlataformaManager {
    
    static let shared = PlataformaManager()
    var plataformas: [Plataforma] = []
    
    func loadPlataformas(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Plataforma> = Plataforma.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            plataformas = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    func deletePlataforma(index: Int, context: NSManagedObjectContext) {
        let plataforma = plataformas[index]
        context.delete(plataforma)
        
        do {
            try context.save()
            plataformas.remove(at: index)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    private init() {
        
    }
}
