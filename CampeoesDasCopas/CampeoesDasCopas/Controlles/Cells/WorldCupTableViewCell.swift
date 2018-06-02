//
//  WorldCupTableViewCell.swift
//  CampeoesDasCopas
//
//  Created by Aluno on 02/06/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class WorldCupTableViewCell: UITableViewCell {

    // IBOutlets
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var winnerImg: UIImageView!
    @IBOutlet weak var winnerLbl: UILabel!
    @IBOutlet weak var winnerScoreLbl: UILabel!
    @IBOutlet weak var viceImg: UIImageView!
    @IBOutlet weak var viceLbl: UILabel!
    @IBOutlet weak var viceScoreLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(withWorldCup worldCup: WorldCup) {
        yearLbl.text = "\(worldCup.year)"
        countryLbl.text = worldCup.country
        winnerImg.image = UIImage(named: worldCup.winner)
        winnerLbl.text = worldCup.winner
        winnerScoreLbl.text = worldCup.winnerScore
        viceImg.image = UIImage(named: worldCup.vice)
        viceLbl.text = worldCup.vice
        viceScoreLbl.text = worldCup.viceScore
    }

}
