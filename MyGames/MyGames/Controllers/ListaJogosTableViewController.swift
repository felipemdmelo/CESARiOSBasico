//
//  ListaJogosTableViewController.swift
//  MyGames
//
//  Created by Aluno on 20/07/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit
import CoreData

class ListaJogosTableViewController: UITableViewController {
    
    // esse tipo de classe oferece mais recursos para monitorar os dados
    var fetchedResultController:NSFetchedResultsController<Jogo>!
    
    var label = UILabel()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // mensagem default
        label.text = "Você não tem jogos cadastrados"
        label.textAlignment = .center
        
        // altera comportamento default que adicionava background escuro sobre a view principal
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        
        navigationItem.searchController = searchController
        
        // usando extensions
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        loadJogo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "jogoSegue" {
            print("jogoSegue")
            let vc = segue.destination as! JogoViewController
            
            if let jogos = fetchedResultController.fetchedObjects {
                vc.jogo = jogos[tableView.indexPathForSelectedRow!.row]
            }
            
        } else if segue.identifier! == "novoJogoSegue" {
            print("novoJogoSegue")
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController?.fetchedObjects?.count ?? 0
        
        tableView.backgroundView = count == 0 ? label : nil
        
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListaJogosTableViewCell

        guard let jogo = fetchedResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: jogo)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let jogo = fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            context.delete(jogo)
            
            do {
                try context.save()
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadJogo() {
        // Coredata criou na classe model uma funcao para recuperar o fetch request
        let fetchRequest: NSFetchRequest<Jogo> = Jogo.fetchRequest()
        
        // definindo criterio da ordenacao de como os dados serao entregues
        let nomeJogoSortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [nomeJogoSortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // valor default evita precisar ser obrigado a passar o argumento quando chamado
    func loadJogos(filtering: String = "") {
        let fetchRequest: NSFetchRequest<Jogo> = Jogo.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if !filtering.isEmpty {
            // usando predicate: conjunto de regras para pesquisas
            // contains [c] = search insensitive (nao considera letras identicas)
            let predicate = NSPredicate(format: "nome contains [c] %@", filtering)
            fetchRequest.predicate = predicate
        }
        
        // possui
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch  {
            print(error.localizedDescription)
        }
    }

}

extension ListaJogosTableViewController: NSFetchedResultsControllerDelegate {
    
    // sempre que algum objeto for modificado esse metodo sera notificado
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default:
            tableView.reloadData()
        }
    }
}

extension ListaJogosTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadJogos()
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadJogos(filtering: searchBar.text!)
        tableView.reloadData()
    }
}
