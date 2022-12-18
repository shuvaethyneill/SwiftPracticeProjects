//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Shuvaethy Neill on 2022-12-02.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImageNumber: Int?
    var totalImageCount: Int?
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(selectedImageNumber!) of \(totalImageCount!)" 
        navigationItem.largeTitleDisplayMode = .never
        
        // button on right of nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // check and unwrap optional
        if let imageToLoad = selectedImage {
            // selectedImage has a value and will passed to UIImage and loaded
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let activityVewController = UIActivityViewController(activityItems: [image, selectedImage!], applicationActivities: [])
        // mandatory on ipad to show where the sharing comes from
        activityVewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVewController, animated: true)
    }
}
