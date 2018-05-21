//
//  NovaTransacaoViewController.swift
//  ProjetoiOSBasico
//
//  Created by Aluno on 12/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class NovaTransacaoViewController: UIViewController {

    @IBOutlet weak var informeValorTextField: UITextField!
    
    // Model information - Usuario Logado..
    var usuario = UsuarioModel()
    
    // Repository information..
    let bancoRepository = BancoRepository.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Nova Transacao"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    @IBAction func salvar(_ sender: Any) {
        let transacaoModel = TransacaoModel()
        let valor:Int? = Int(informeValorTextField.text!)
        if valor != nil && valor != 0 {
            transacaoModel.valor = valor!
            bancoRepository.insert(value: transacaoModel)
            
            self.navigationController?.popViewController(animated: true)
        } else {
            exibirMensagem(titulo: "Erro!", mensagem: "Informacao invalida.")
        }
    }
    
    func exibirMensagem(titulo: String, mensagem: String) {
        let alert = UIAlertController(title: titulo,
                                      message: mensagem,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}
