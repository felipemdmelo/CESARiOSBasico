//
//  WorldCupViewController.swift
//  CampeoesDasCopas
//
//  Created by Aluno on 01/06/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class WorldCupViewController: UIViewController {

    @IBOutlet weak var winnerImg: UIImageView!
    @IBOutlet weak var winnerLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var viceImg: UIImageView!
    @IBOutlet weak var viceLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var worldCup: WorldCup!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\(worldCup.winner)")
        
        title = "Copa \(worldCup.year)"
        
        winnerImg.image = UIImage(named: worldCup.winner)
        winnerLbl.text = worldCup.winner
        scoreLbl.text = "\(worldCup.winnerScore) x \(worldCup.viceScore)"
        viceImg.image = UIImage(named: worldCup.vice)
        viceLbl.text = worldCup.vice
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension WorldCupViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return worldCup.matches.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return worldCup.matches[section].stage
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let games = worldCup.matches[section].games
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesTableViewCell
        
        let match = worldCup.matches[indexPath.section]
        let game = match.games[indexPath.row]
        
        cell.prepare(with: game)
        
        return cell
    }
}

extension WorldCupViewController: UITableViewDelegate {
    
}
