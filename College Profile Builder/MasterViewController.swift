//
//  MasterViewController.swift
//  College Profile Builder
//
//  Created by Tconti on 2/6/17.
//  Copyright © 2017 Conti Inc. All rights reserved.
//

import UIKit
import SafariServices
import UIKit
import RealmSwift


class MasterViewController: UITableViewController {
    
    dynamic var detailViewController: DetailViewController? = nil
    dynamic var objects = [Any]()
    let realm = try! Realm()
    lazy var colleges: Results<College> = {
        self.realm.objects(College.self)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup  after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        for college in colleges {
            objects.append(college)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    func insertNewObject(_ sender: Any) {
        let alert = UIAlertController(title: "Add College", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in textField.placeholder = "Name of College"
        }
        alert.addTextField { (textField) in textField.placeholder = "Location of College"
        }
        alert.addTextField { (textField) in textField.placeholder = "Enrollment Size"
            textField.keyboardType = UIKeyboardType.numberPad
        }
        alert.addTextField { (textField) in textField.placeholder = "Website URL"
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let insertAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let nameTextField = alert.textFields![0] as UITextField
            let locationTextField = alert.textFields![1] as UITextField
            let populationTextField = alert.textFields![2] as UITextField
            let websiteTextField = alert.textFields![3] as UITextField
            guard let image = UIImage(named: nameTextField.text!) else {
                print("missing \(nameTextField.text!) image")
                return
            }
            if let population = Int(populationTextField.text!) {
                let college = College(name: nameTextField.text!, location: locationTextField.text!, numberOfStudents: population, image: UIImagePNGRepresentation(image)!, website: websiteTextField.text!)
                self.objects.append(college)
                try! self.realm.write {
                    self.realm.add(college)
                }
                self.tableView.reloadData()
                
            }
        }
        alert.addAction(insertAction)
        present(alert, animated: true, completion: nil)
    }
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! College
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = objects[indexPath.row] as! College
        cell.textLabel!.text = object.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let college = objects.remove(at: indexPath.row) as! College
            try! self.realm.write {
                self.realm.delete(college)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
