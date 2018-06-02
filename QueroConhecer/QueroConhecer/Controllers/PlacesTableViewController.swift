//
//  PlacesTableViewController.swift
//  QueroConhecer
//
//  Created by Aluno on 02/06/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    
    // estrutura para armazenar os Places
    var places: [Place] = []
    
    // persistence
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadPlaces()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        let place = places[indexPath.row]
        cell.textLabel?.text = place.name
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "finderSegue" {
            let vc = segue.destination as! PlaceFinderViewController
            vc.delegate = self
        }
    }
    
    func loadPlaces() {
        
        if let placeData = ud.data(forKey: "places") {
            do {
                places = try JSONDecoder().decode([Place].self, from: placeData)
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func savePlaces() {
        do {
            let json = try JSONEncoder().encode(places)
            self.ud.setValue(json, forKey: "places")
        } catch {
            print(error.localizedDescription)
        }
    }

}

extension PlacesTableViewController: PlaceFinderDelegate {
    
    func addPlace(_ place: Place) {
        
        // 1
        
        // Como evitar que um place de mesma (longitude e latitude) seja adicionado?
        // evita que um place (mesma longitude e latitude) seja adicionado
        if !places.contains(place) {
            // save
            self.places.append(place)
            self.savePlaces()
            self.tableView.reloadData()
        }
        
    }
}
