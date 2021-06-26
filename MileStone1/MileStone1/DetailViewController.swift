//
//  DetailViewController.swift
//  MileStone1
//
//  Created by ecinar on 26.06.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedImage: String!
    var selectedImagePath: Int?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareCountry) )
        
        print("detaile geldi \(selectedImage) ")
        if let imageToLoad = selectedImage{
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    @objc func shareCountry(){
        guard let image = imageView.image?.jpegData(compressionQuality: 1) else {
            print("there is no image")
            return
        }
        let ac = UIActivityViewController(activityItems: [selectedImage,image], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}
