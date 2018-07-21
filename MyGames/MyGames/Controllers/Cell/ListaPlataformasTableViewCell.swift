//
//  ListaPlataformasTableViewCell.swift
//  MyGames
//
//  Created by Aluno on 21/07/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class ListaPlataformasTableViewCell: UITableViewCell {

    @IBOutlet weak var plataformaFotoImg: UIImageView!
    @IBOutlet weak var plataformaNomeLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with plataforma: Plataforma) {
        plataformaNomeLb.text = plataforma.nome
        if let image = plataforma.foto as? UIImage {
            plataformaFotoImg.image = image
        } else {
            plataformaFotoImg.image = UIImage(named: "noCover")
        }
    }

}
