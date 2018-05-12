//
//  MyTableTableViewController.swift
//  TableView
//
//  Created by Aluno on 12/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class MyTableTableViewController: UITableViewController {
    
    let stringRepository = StringRepository.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Section \(section + 1)"
        } else {
            return "Section \(section + 2)"
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Footer \(section + 1)"
        } else {
            return "Footer \(section + 1)"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return stringRepository.size()
        } else {
            return stringRepository.size() // teria aqui a outra secao
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "my_cell", for: indexPath)

        let section = indexPath.section
        if section == 0 {
            let textValue = stringRepository.get(at: indexPath.row)
            let detailValue = "Detail \(indexPath.row + 1)"
            
            // Configure the cell...
            cell.textLabel?.text = textValue
            cell.detailTextLabel?.text = detailValue
            //cell.imageView?.image = nil
            
            return cell
        } else {
            let textValue = stringRepository.get(at: indexPath.row)
            let detailValue = "Detail \(indexPath.row + 1)"
            
            // Configure the cell...
            cell.textLabel?.text = textValue
            cell.detailTextLabel?.text = detailValue
            //cell.imageView?.image = nil
            
            return cell
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let section = indexPath.section
            if section == 0 {
                // Delete the row from the data source
                _ = stringRepository.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                // Delete the row from the data source
                _ = stringRepository.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
