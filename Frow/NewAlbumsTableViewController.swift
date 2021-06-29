//
//  NewAlbumsTableViewController.swift
//  Frow
//
//  Created by ehsan sat on 6/29/21.
//  Copyright © 2021 ehsan sat. All rights reserved.
//

import UIKit

class NewAlbumsTableViewController: UITableViewController {
    
    var acceessToken: String = "0" {
        didSet {
            print("we got token")
        }
    }
    
    let network = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    override func viewWillAppear(_ animated: Bool) {
        
        let url = URL(string: "https://accounts.spotify.com/api/token")
        
        let dataUrl = URL(string: "https://api.spotify.com/v1/browse/new-releases")
        
        network.requestLogin(url: url!, successHandler: { (data) in
            print(data.base64EncodedString())
            self.network.getDataFromAPI(url: dataUrl!, token: data.base64EncodedString(), successHandler: { (data) in
//                print("json object: \(data.base64EncodedString())")
//                let responseObject = try? JSONDecoder().decode(Data.self, from: data)
//                print(responseObject?.description)
                do {
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    print("last try")
                } catch {
                    print(error)
                }
                

            }) { (error) in
                print(error)
            }
        }) { (error) in
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
