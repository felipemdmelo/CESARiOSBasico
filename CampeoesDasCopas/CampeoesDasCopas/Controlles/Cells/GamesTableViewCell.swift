//
//  GamesTableViewCell.swift
//  CampeoesDasCopas
//
//  Created by Aluno on 02/06/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var awayLbl: UILabel!
    @IBOutlet weak var awayImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with game: Game) {
        homeImg.image = UIImage(named: game.home)
        homeLbl.text = game.home
        scoreLbl.text = game.score
        awayImg.image = UIImage(named: game.away)
        awayLbl.text = game.away
    }

}
