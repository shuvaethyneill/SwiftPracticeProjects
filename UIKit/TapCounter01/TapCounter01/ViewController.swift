//
//  ViewController.swift
//  TapCounter01
//
//  Created by Shuvaethy Neill on 2022-12-08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Outlets
    @IBOutlet weak var countLabel: UILabel!
    
    //MARK: - Properties
    var count = 0

    //MARK: - Interactions
    @IBAction func tapCounter(_ sender: UIButton) {
        count+=1
        countLabel.text = String(count)
    }
    
    
    @IBAction func tapResetButton(_ sender: UIBarButtonItem) {    count = 0
        countLabel.text = "0"
        
    }
    
    
}

