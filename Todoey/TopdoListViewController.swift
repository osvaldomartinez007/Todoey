//
//  ViewController.swift
//  Todoey
//
//  Created by OSVALDO MARTINEZ on 5/27/19.
//  Copyright © 2019 OSVALDO MARTINEZ. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {

//var textField : String = "blag"
    
    // simly by inheriting the uitableviewcontroller you dont need to add ourselves as a delegate nor variables, dont need to add any IBoutlets
    
    // let cell : UITableViewCell
    
    // var textField = UITextField()   -  does not work here
    var itemArray=["Find Nemo","Buy Eggs", "Destroy Demogorgon"]
    
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
    
    // MARK - add Todoey bar button item method
    
    @IBAction func addItemTodoeyPressed(_ sender: Any) {
        
        // to get this  variable typed!! I guess you need to put the UITextField() and not the usual type
        
        var textField = UITextField() // extending scope of the closures within function
        
        
        let alert = UIAlertController(title: "Add new list item", message: "", preferredStyle: .alert)
        
        // adding an alert object
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when the user touches the add button
            
            
            print("success")
            print(textField.text) // this will print out as an optional and then inside will be the text
            print(textField.text!)
            self.itemArray.append(textField.text!)
            // can add a default value ?? "added item" for example. (textField.text ?? "added item") or you can put an if statement asking if its nil ""
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item"
            textField = alertTextField
            print(alertTextField.text!)
            print(textField.text!)
            print("now")
        }
        
        alert.addAction(action)
        present (alert, animated: true, completion: nil)

    }
    
    
}

