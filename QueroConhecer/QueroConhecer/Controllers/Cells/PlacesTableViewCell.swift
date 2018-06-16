//
//  PlacesTableViewCell.swift
//  QueroConhecer
//
//  Created by Aluno on 16/06/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

//1. delegate method
protocol PlacesTableViewCellDelegate: AnyObject {
    
    func tracarRota(cell: PlacesTableViewCell)
    
}

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var iconeImg: UIImageView!
    @IBOutlet weak var nomeLbl: UILabel!
    @IBOutlet weak var detalheLbl: UILabel!
    
    var indexPath = 0
    
    //2. create delegate variable
    weak var delegate: PlacesTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //3. assign this action to close button
    @IBAction func tracarRota(_ sender: Any) {
        //4. call delegate method
        //check delegate is not nil with `?`
        delegate?.tracarRota(cell: self)
    }
    
    func prepare(_ place: Place) {
        nomeLbl.text = place.name
        detalheLbl.text = "Endereço: \(place.address)"
    }

}
