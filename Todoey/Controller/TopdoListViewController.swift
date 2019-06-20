//
//  ViewController.swift
//  Todoey
//
//  Created by OSVALDO MARTINEZ on 5/27/19.
//  Copyright © 2019 OSVALDO MARTINEZ. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController : UITableViewController {
    
    // simly by inheriting the uitableviewcontroller you dont need to add ourselves as a delegate nor variables, dont need to add any IBoutlets
    // anything up here before the viewdidload are shared constants
 
    // added a path to the new plist
    var itemArray=[Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // tapping into UIApplication class and getting the "shared" singleton object, tapping into its delegate (this is the app delegate and all apps need an app delegate to respond to app-related messages. For example, the app notifies its delegate when the app finishes launching). Casting the app delegate into our class AppDelegate. We now have access to our AppDelegate class as an object and can grab (with point notation) the property the viewContext of that persistentContainer
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    } // in swift if the selectedCategory has an item then the functions in the didSet will be triggered, question after the category means that the selectedCategory has an optional Category.. not sure that there is a category

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // grabbing first item from the array
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)) // where is our data?
    
        //searchBar.delegate = self // apparently in searchBar this is optional
        
        // problem here with itemArray is if the defaults does not exist ie the first time you run the program and then it will crash because no array has been copied into the p list defaults object
        
//        if let items = defaults.array(forKey: "ItemArray") as? [Item] {
//            itemArray=items
//        }
        
        
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

        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text=item.itemName
        
        // cut down code with ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
 
 cell.accessoryType = item.checked ? .checkmark : .none
        
// cell.accessoryType = item.checked == true ? .checkmark : .none
        
//                if item.checked == false {
//
//                    cell.accessoryType = .none
//
//                } else {
//
//                    cell.accessoryType = .checkmark
//
//                }
       
        return cell
        
    }

    //MARK: TableView Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // print(itemArray[indexPath.row])
 
       // itemArray[indexPath.row].setValue("completed", forKey: "itemName") // changes value at row to completed after touching it
        
    itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked // sends back the opposite
        
       // context.delete(itemArray[indexPath.row]) // removes the data from coreData and order matters greatly
        
       // itemArray.remove(at: indexPath.row) // removes the data from itemArray which is used ot populate the tableview
       
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
        
        // tableView.reloadData() now in function saveItems
        
    }
    
    // MARK - add Todoey bar button item method
    
    @IBAction func addItemTodoeyPressed(_ sender: Any) {
        
        // to get this  variable typed!! I guess you need to put the UITextField() and not the usual type
        
        var textField = UITextField() // extending scope of the closures within function
        
        
        let alert = UIAlertController(title: "Add new list item", message: "", preferredStyle: .alert)
        
        // adding an alert object
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      
          
            let itemArrayToAdd = Item(context: self.context) // opening an open bracket after the object (in this case NSMAnagedObject then you initialize it specifying the context where the object will exist (viewcontext of container)
            itemArrayToAdd.itemName=textField.text!
            itemArrayToAdd.checked=false
            itemArrayToAdd.categoryRelationship = self.selectedCategory

            self.itemArray.append(itemArrayToAdd)
            
            // can add a default value ?? "added item" for example. (textField.text ?? "added item") or you can put an if statement asking if its nil ""
            //self.defaults.set(self.itemArray, forKey: "ItemArray") // in a closure so self for both items
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item"
            textField = alertTextField
            print(alertTextField.text!)
            print(textField.text!)
            print(self.itemArray)
            print("now")
        }
        
        alert.addAction(action)
        
        present (alert, animated: true, completion: nil)

    }
    
    func saveItems() {
        
        do {
            try context.save() // need to grab context!
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
        // yay reloaded and displayed the tableView!
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
      // external parameter "with" used when the function is called while the internal parameter "request" is used in the function
        
        //when you put an equal sign in the function then that value becomes the default value and then you can loadItems ()
        
        // let request : NSFetchRequest<Item> = Item.fetchRequest()   this line is no longer needed since you dont need to initialize the "request" since you are passing it in from the function
        
      let categoryPredicate = NSPredicate(format: "categoryRelationship.name MATCHES %@", selectedCategory!.name!)
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate!])
        
        // added two simultaneous predicates using compound predicate
        // instead of force unwrapping with ! we can make sure we are safe by taking the two statements above and performing an if let
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        // in this way we make sure that we never unwrap a nil value : using optional binding
        
       // request.predicate = compoundPredicate..putting an if let so that there is no nil .. if and then let makes sure it is not "nil"
        
        do {
        itemArray = try context.fetch(request)
        } catch {
            print("Error in loading/fetching the items from CoreData \(error)")
        }
        
        tableView.reloadData()
        // yay reloaded and displayed the tableView!
    }
    
   
    
    
    
}
//MARK: search bar delegate
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "itemName CONTAINS[cd] %@", searchBar.text!) // adding cd in square brackets makes it insensitive to case and diacritics like accents
        
        request.predicate = predicate
        
        // you can replace with request.predicate = NSPredicate(format: "itemName CONTAINS[cd] %@", searchBar.text!)
        
        let sortDescriptr = NSSortDescriptor(key: "itemName", ascending: true) // if you say true then it will be alphabetically sorted
        
        request.sortDescriptors = [sortDescriptr]
        
        // you can replace with request.sortDescriptors = [NSSortDescriptor(key: "itemName", ascending: true)] after adding the square brackets because its expecting an array
        
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error in loading/fetching the items from CoreData \(error)")
//        }
//
//        tableView.reloadData()
//

        // this can all be replaced by calling the function with a retrievable function. What will be retrieved is the request : NSfetchrequest<Item>
        
        loadItems(with: request, predicate: predicate)

    }
    
    // new delegate method = any changes in the search bar text
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" {
        //  the if statement above seems to work the same as if searchBar.text?.count == 0
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
           
        }
        
    }
    
    
}




