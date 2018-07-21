//
//  ListaPlataformasTableViewController.swift
//  MyGames
//
//  Created by Aluno on 20/07/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class ListaPlataformasTableViewController: UITableViewController {

    var plataformaManager = PlataformaManager.shared
    
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // mensagem default
        label.text = "Você não tem plataformas cadastradas"
        label.textAlignment = .center
        
        loadPlataformas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPlataformas()
    }
    
    func loadPlataformas() {
        plataformaManager.loadPlataformas(with: context)
        tableView.reloadData()
    }
    
    /*func showAlert(with plataforma: Plataforma?) {
        let title = plataforma == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Nome da plataforma"
            
            if let name = plataforma?.nome {
                textField.text = name
            }
        })
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: {(action) in
            let plataforma = plataforma ?? Plataforma(context: self.context)
            plataforma.nome = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadPlataformas()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        
        present(alert, animated: true, completion: nil)
    }*/

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = plataformaManager.plataformas.count
        
        tableView.backgroundView = count == 0 ? label : nil
        
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListaPlataformasTableViewCell
        
        let plataforma = plataformaManager.plataformas[indexPath.row]
        
        cell.prepare(with: plataforma)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            plataformaManager.deletePlataforma(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AdicionarEditarPlataformaViewController
        
        if segue.identifier == "plataformaEditarSegue" {
            let plataformas = plataformaManager.plataformas
            vc.plataforma = plataformas[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    // a ação não será mais abrir um alert e sim uma nova tela para cadastramento
    /*@IBAction func adicionarPlataforma(_ sender: UIBarButtonItem) {
        print("adicionarPlataforma")
        showAlert(with: nil)
    }*/
    
}
