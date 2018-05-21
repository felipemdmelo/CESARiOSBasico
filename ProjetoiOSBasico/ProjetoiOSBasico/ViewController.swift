//
//  ViewController.swift
//  ProjetoiOSBasico
//
//  Created by Aluno on 12/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var usuario = UsuarioModel()

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func entrarButtonAction(_ sender: Any) {
        // Pega as informacoes do formulario e monta um usuario..
        usuario = gerarUsuarioLoginDoForm()
        // Validacoes..
        if usuario.login.count < 4 {
            exibirMensagem(titulo: "Erro!", mensagem: "O campo login deve ter no minimo 4 caracteres.")
            print("Erro! O campo login deve ter no minimo 4 caracteres.")
        } else if usuario.senha.count < 4 {
            exibirMensagem(titulo: "Erro!", mensagem: "O campo senha deve ter no minimo 4 caracteres.")
            print("Erro! O campo senha deve ter no minimo 4 caracteres.")
        } else if usuario.login == "Felipe" &&
            usuario.senha == "1234" {
            irParaExtratoTableView()
        } else {
            exibirMensagem(titulo: "Erro!", mensagem: "Usuario e/ou senha invalidos.")
            print("Erro! Usuario e/ou senha invalidos.")
        }
    }
    
    func irParaExtratoTableView() {
        let extratoView = storyboard?.instantiateViewController(withIdentifier: "ExtratoTableTableViewController") as! ExtratoTableTableViewController
        // Simulando o nome para o usuario..
        usuario.nome = "Felipe Melo"
        extratoView.usuario = usuario
        navigationController?.pushViewController(extratoView, animated: true)
    }
    
    func gerarUsuarioLoginDoForm() -> UsuarioModel {
        let rtn = UsuarioModel()
        if loginTextField.text != nil &&
            senhaTextField.text != nil {
            rtn.login = loginTextField.text!
            rtn.senha = senhaTextField.text!
        }
        
        return rtn
    }
    
    func exibirMensagem(titulo: String, mensagem: String) {
        let alert = UIAlertController(title: titulo,
                                      message: mensagem,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

