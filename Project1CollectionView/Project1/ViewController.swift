//
//  ViewController.swift
//  Project1
//
//  Created by ecinar on 23.06.2021.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var subtitles = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                subtitles.append(0)
                
            }
        
        }
        print(subtitles.count)
        pictures.sort()
        print(pictures)
        let defaults = UserDefaults.standard
        
        if let array = defaults.object(forKey:"SavedArray") as? [Int] {
            subtitles = array
        }

        
    }
    
    @objc func uploadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                
            }
            
        }
        pictures.sort()
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = String(subtitles[indexPath.row])
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.numberOfImages = pictures.count
            vc.selectedImagePath = Int(indexPath.row) + 1
            vc.subtitleArray = subtitles
            subtitles[indexPath.row] += 1
            vc.index = indexPath.row
            
            self.navigationController?.pushViewController(vc, animated: true)
            tableView.reloadData()
        }
    }
}
