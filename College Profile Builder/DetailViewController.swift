//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by Tconti on 2/6/17.
//  Copyright © 2017 Conti Inc. All rights reserved.
//

import UIKit
import RealmSwift


class DetailViewController: UIViewController {
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var populationTextField: UITextField!
    @IBOutlet weak var collegeImageView: UIImageView!
    
let realm = try! Realm()
    var detailItem: College? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    func configureView() {
        // Update the user interface for the detail item.
        if let college = self.detailItem {
                if nameTextField != nil {
                    locationTextField.text = college.name
                    populationTextField.text = college.population
                    collegeTextField.text = String(college.population)
                    collegeImageView.image = UIImage(data: college.image)

            }
        }
    }
}

