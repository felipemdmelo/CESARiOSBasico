//
//  HomeViewController.swift
//  ProjetoiOSBasico
//
//  Created by Aluno on 12/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bemVindoLabel: UILabel!

    @IBOutlet weak var extratoTableView: UITableView!
    
    // Model information - Usuario Logado..
    var usuario = UsuarioModel()
    
    // Repository information..
    let bancoRepository = BancoRepository.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Exibir mensagem de bem vindo..
        bemVindoLabel.text = "Bem vindo, \(usuario.nome)!"
        
        // Configura delegate e data source para este controller..
        extratoTableView.delegate = self
        extratoTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bancoRepository.size()
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return bancoRepository.saldoDescricao()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
