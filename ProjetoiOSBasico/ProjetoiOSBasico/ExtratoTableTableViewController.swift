//
//  ExtratoTableTableViewController.swift
//  ProjetoiOSBasico
//
//  Created by Aluno on 21/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class ExtratoTableTableViewController: UITableViewController {
    
    @IBOutlet var extratoTableView: UITableView!
    
    // Model information - Usuario Logado..
    var usuario = UsuarioModel()
    
    // Repository information..
    let bancoRepository = BancoRepository.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationItem.title = "Extrato"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        extratoTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bancoRepository.size()
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return bancoRepository.saldoDescricao()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransacaoCell", for: indexPath)
        
        // Configure the cell...
        let section = indexPath.section
        if section == 0 {
            let transacao = bancoRepository.get(at: indexPath.row)
            let detailValue = "Nome do estabelecimento" // Ideia para incrementar..
            
            // Configure the cell...
            cell.textLabel?.text = transacao.descricao
            cell.textLabel?.textColor = transacao.ehNegativo ? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1) : #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.detailTextLabel?.text = detailValue
            //cell.imageView?.image = nil
            
            return cell
        }
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "HomeSegueNovaTransacao") {
            let nextView = (segue.destination as! NovaTransacaoViewController)
            nextView.usuario = usuario
        }
    }

}
