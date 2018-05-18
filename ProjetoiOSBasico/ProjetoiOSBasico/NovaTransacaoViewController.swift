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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let transacaoModel = TransacaoModel()
        let valor:Int? = Int(informeValorTextField.text!)
        if valor != nil && valor != 0 {
            transacaoModel.valor = valor!
            bancoRepository.insert(value: transacaoModel)
        }
        
        if(segue.identifier == "NovaTransacaoSegueHome") {
            let nextView = (segue.destination as! HomeViewController)
            nextView.usuario = usuario
        }
    }

}
