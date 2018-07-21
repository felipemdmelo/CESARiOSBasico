//
//  JogoViewController.swift
//  MyGames
//
//  Created by Aluno on 21/07/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class JogoViewController: UIViewController {

    @IBOutlet weak var nomeJogoLb: UILabel!
    @IBOutlet weak var nomePlataformaLb: UILabel!
    @IBOutlet weak var dataLancamentoLb: UILabel!
    @IBOutlet weak var capaJogoImg: UIImageView!
    @IBOutlet weak var plataformaFotoImg: UIImageView!
    
    var jogo: Jogo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nomeJogoLb.text = jogo.nome
        nomePlataformaLb.text = jogo.plataforma?.nome
        if let dataLancamento = jogo.dataLancamento {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "pt-BR")
            dataLancamentoLb.text = "Lançamento: " + formatter.string(from: dataLancamento)
        }
        
        if let image = jogo.capa as? UIImage {
            capaJogoImg.image = image
        } else {
            capaJogoImg.image = UIImage(named: "noCoverFull")
        }
        
        if let image = jogo.plataforma?.foto as? UIImage {
            plataformaFotoImg.image = image
        } else {
            plataformaFotoImg.image = UIImage(named: "noCoverFull")
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AdicionarEditarViewController
        vc.jogo = jogo
    }

}
