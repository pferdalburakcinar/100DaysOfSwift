//
//  ViewController.swift
//  Project1
//
//  Created by ecinar on 23.06.2021.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pictures = [String]()
    var pictureNames = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addNewPerson))
        uploadImages()
    }
    
    @objc func uploadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                pictureNames.append(item)
            }
            
        }
        pictures.sort()
        print(pictures)
    }
    
    @objc func uploadNewImage() {
        
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        var urlString = try? String(contentsOf: imagePath)
        pictures.append(imagePath.path)
        pictureNames.append(imagePath.path)
        dismiss(animated: true)
        tableView.reloadData()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictureNames[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ac = UIAlertController(title: "Rename Or Detail", message: nil, preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "Go Detail", style: .default) { _ in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                vc.selectedImage = self.pictures[indexPath.row]
                vc.numberOfImages = self.pictures.count
                vc.selectedImagePath = Int(indexPath.row) + 1
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        let renameImage = UIAlertAction(title: "Rename", style: .default) { _ in
            let deepac = UIAlertController(title: "Rename Or Detail", message: nil, preferredStyle: .alert)
            deepac.addTextField()
            let changeNameFromTextfield = UIAlertAction(title: "Change NAme", style: .default){ _ in
                guard let newName = deepac.textFields?[0].text else { return }
                self.pictureNames[indexPath.row] = newName
                tableView.reloadData()
            }
            
            
            deepac.addAction(changeNameFromTextfield)
     

            self.present(deepac, animated: true)
            
        }
        
        ac.addAction(submitAction)
        ac.addAction(renameImage)
        present(ac, animated: true)
        
    }
    
    
    func asd(indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.numberOfImages = pictures.count
            vc.selectedImagePath = Int(indexPath.row) + 1
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
