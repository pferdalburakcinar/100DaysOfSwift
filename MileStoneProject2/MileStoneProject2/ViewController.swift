//
//  ViewController.swift
//  MileStoneProject2
//
//  Created by ecinar on 29.06.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        shoppingList.append("deneme")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(shareButtonTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingList", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            
            self?.shoppingList.insert(answer, at: 0)
            self?.tableView.reloadData()
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func shareButtonTapped(){

        let list = shoppingList.joined(separator: "\n")
        print(list)
        let ac = UIActivityViewController(activityItems: [list], applicationActivities: [])
        ac.isModalInPresentation = true

        ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(ac, animated: true)
    }
}

