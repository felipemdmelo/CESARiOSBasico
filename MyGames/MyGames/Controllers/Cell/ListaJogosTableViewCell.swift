//
//  ListaJogosTableViewCell.swift
//  MyGames
//
//  Created by Aluno on 21/07/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class ListaJogosTableViewCell: UITableViewCell {

    @IBOutlet weak var jogoImg: UIImageView!
    @IBOutlet weak var jogoNomeLb: UILabel!
    @IBOutlet weak var plataformaNomeLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with jogo: Jogo) {
        jogoNomeLb.text = jogo.nome
        plataformaNomeLb.text = jogo.plataforma?.nome
        
        if let image = jogo.capa as? UIImage {
            jogoImg.image = image
        } else {
            jogoImg.image = UIImage(named: "noCover")
        }
    }

}
