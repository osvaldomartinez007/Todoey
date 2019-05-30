//
//  ViewController.swift
//  Todoey
//
//  Created by OSVALDO MARTINEZ on 5/27/19.
//  Copyright © 2019 OSVALDO MARTINEZ. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {


    // simly by inheriting the uitableviewcontroller you dont need to add ourselves as a delegate nor variables, dont need to add any IBoutlets
    
    //let cell : UITableViewCell
    
    
    let itemArray=["Find Nemo","Buy Eggs", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK - TableView Datasource Methods
    
    // methods include number of rows
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    // creates 3 cells
    
    // method display
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        cell.textLabel?.text=itemArray[indexPath.row]
        return cell
        
    }

// MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // print(itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
    }
    
    
    
}
