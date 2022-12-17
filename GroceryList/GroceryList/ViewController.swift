//
//  ViewController.swift
//  GroceryList
//
//  Created by Shuvaethy Neill on 2022-12-16.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title
        title = "Grocery List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavigationBar()
    }
    
    // Method to setup nav bar button items
    fileprivate func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearListTapped))

        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
        let helpInfoButton = UIButton(type: .infoLight)
        helpInfoButton.addTarget(self, action: #selector(displayHelpInfo), for: .touchUpInside)
        
        let help = UIBarButtonItem(customView: helpInfoButton)
        
        navigationItem.rightBarButtonItems = [help, add]
    }
    
    // Method that returns number of rows (table cells) in a section. In this case, however many items in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    // Method that returns the table cell at a specific index path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        // Configure table cell details
        content.text = itemList[indexPath.row]
        content.textProperties.color = .darkGray
        cell.contentConfiguration = content
        
        return cell
    }
    
    // Method that asks for editing style of a specific row. In this case, I only use delete
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Method to act on editing style
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove item from array and table view
            itemList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func clearListTapped() {
        if itemList.isEmpty {
            return showAlert(title: "List already empty", message: "You have no items to clear!", withCancelButton: false, handler: nil)
        }
        
        showAlert(title: "Are you sure want to clear?", message: "All \(itemList.count) item(s) will be deleted", withCancelButton: true, handler: clearList(action:))
    }
    
    @objc func addItemTapped() {
        let alertController = UIAlertController(title: "New item", message: "Enter an item to add it to the list", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Item"
        }
        
        // Avoid strong reference cycle by capturing self (current view controller) and alertController as weak references in closure
        // Closure expects a UIAlertAction param but since we do not use it inside we can mark with _
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController] _ in
            // Optional by default so we have to unwrap with optional chaining
            guard let item = alertController?.textFields?[0].text else { return }
            self?.addNewItem(item)
        }
                
        alertController.addAction(addAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    @objc func displayHelpInfo() {
        var helpMessage = """
                          Click the \"+\" to add a new item. \n
                          Click \"Clear\" to erase all list items. \n
                          To delete a single item from your list, swipe the item to the left.
                          """
        
        showAlert(title: "Help Guide", message: helpMessage, withCancelButton: false, handler: nil)
    }
    
    fileprivate func clearList(action: UIAlertAction) {
        self.itemList.removeAll(keepingCapacity: true)
        self.tableView.reloadData()
    }
    
    fileprivate func addNewItem(_ item: String) {
        if itemIsDuplicate(item) {
            return showAlert(title: "Duplicate entry", message: "\(item) is already on your list!", withCancelButton: false, handler: nil)
        }
        
        if item.trimmingCharacters(in: .whitespaces).isEmpty {
            return showAlert(title: "Empty", message: "Oops you entered nothing", withCancelButton: false, handler: nil)
        }
        
        itemList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    fileprivate func itemIsDuplicate(_ item: String) -> Bool {
        // compare if item has already been entered by user (case insensitive)
        return itemList.contains(where: {$0.caseInsensitiveCompare(item) == .orderedSame})
    }
    
    fileprivate func showAlert(title: String, message: String?, withCancelButton: Bool, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        
        if withCancelButton {
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
        present(alertController, animated: true)
    }
}
