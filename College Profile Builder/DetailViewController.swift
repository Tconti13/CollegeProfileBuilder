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
            self.configureView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    func configureView() {
        if let college = self.detailItem {
                if nameTextField != nil {
                    nameTextField.text = college.name
                    locationTextField.text = college.location
                    populationTextField.text = String(college.numberOfStudents)
                    collegeImageView.image = UIImage(data: college.image)
            }
        }
    }
    @IBAction func onTappedSubmit(_ sender: UIButton) {
        if let college = self.detailItem {
                try! realm.write ({
                college.name = nameTextField.text!
                college.location = locationTextField.text!
                college.numberOfStudents = Int(populationTextField!)!
                college.image = UIImagePNGRepresentation(collegeImageView.image!)!
                })
            }
        }
    }
