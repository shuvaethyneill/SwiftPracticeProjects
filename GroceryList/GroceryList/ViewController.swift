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
        
        // set bar button items
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(enterItem))
        
        tableView.reloadData()
    }
    
    @objc func clearList() {
        let alertController = UIAlertController(title: "Are you sure want to clear?", message: "All items will be deleted", preferredStyle: .alert)
        
        let reset = UIAlertAction(title: "Yes", style: .destructive) { [weak self]  _ in
            self?.itemList.removeAll(keepingCapacity: true)
            self?.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                   
        alertController.addAction(reset)
        alertController.addAction(cancel)
                   
        present(alertController, animated: true)
    }
    
    @objc func enterItem() {
        let alertController = UIAlertController(title: "New item", message: "Enter an item to add it to the list", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Item"
        }
        
        // avoid strong reference cycle by capturing self (current view controller) and alertController as weak references in closure
        // closure expects a UIAlertAction param but since we do not use it inside we can mark with _
        let add = UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController] _ in
            // optional by default so we have to unwrap with optional chaining
            guard let item = alertController?.textFields?[0].text else { return }
            self?.addNewItem(item)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(add)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
    func addNewItem(_ item: String) {
        itemList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
       
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = itemList[indexPath.row]
        content.textProperties.color = .darkGray
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

