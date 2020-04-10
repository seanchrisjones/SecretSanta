//
//  GifterListTableViewController.swift
//  SecretSanta
//
//  Created by Sean Jones on 4/10/20.
//  Copyright © 2020 Sean Jones. All rights reserved.
//

import UIKit

class GifterListTableViewController: UITableViewController {

    //MARK- OUTLETS
    
    //MARK:- LIFECYCLE FUNCS
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    //MARK:- ACTIONS
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let addGifterController = UIAlertController(title: "Please Enter New Name", message: nil, preferredStyle: .alert)
        
        var gifterNameTextField = UITextField()
        
        addGifterController.addTextField { (textfield) in
            gifterNameTextField = textfield
        }
        
        let addAction = UIAlertAction(title: "Add Gifter", style: .default) { (action) in
            guard let  name = gifterNameTextField.text, !name.isEmpty else {return}
            
            
            let gifter = name
            GifterController.shared.createGifter(gifter: gifter)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addGifterController.addAction(addAction)
        addGifterController.addAction(cancelAction)
        
        self.present(addGifterController, animated: true, completion: nil)
        
    }
    
    @IBAction func shuffleButtonTapped(_ sender: Any) {
        
        let count = GifterController.shared.gifters.count
        
        if count % 2 == 0{
            
            GifterController.shared.shuffle()
            tableView.reloadData()
        }
        else {
            let alert = UIAlertController(title: "There Must be an Even Number", message: "Please add or remove an entity to make the number even", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func findIndex(indexPath: IndexPath) -> Int {
        return (indexPath.section * 2) + (indexPath.row)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return GifterController.shared.gifters.count % 2 == 0 ?
        (GifterController.shared.gifters.count/2) :
            (GifterController.shared.gifters.count/2) + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if GifterController.shared.gifters.count % 2 == 0 {
            return 2
        }
        else {
            
            if section == (tableView.numberOfSections - 1){
                return 1
            }
            else {
                return 2
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pairCell", for: indexPath)

        let gifter = GifterController.shared.gifters[findIndex(indexPath: indexPath)]
        cell.textLabel?.text = gifter

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Gifting Pair #\(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let gifter = GifterController.shared.gifters[findIndex(indexPath: indexPath)]
            GifterController.shared.deleteGifter(gifter: gifter)
            
            tableView.reloadData()
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
