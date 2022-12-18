//
//  ViewController.swift
//  StormViewer
//
//  Created by Shuvaethy Neill on 2022-12-02.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        // enable large titles across app
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
                
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a pic to load
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    // iOS will automatically call this
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create cell by dequeuing a recycled cell from table 
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedImageNumber = indexPath.row + 1
            detailVC.totalImageCount = pictures.count
            detailVC.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

