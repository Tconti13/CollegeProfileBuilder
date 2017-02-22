//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by Tconti on 2/6/17.
//  Copyright © 2017 Conti Inc. All rights reserved.
//

import UIKit
import SafariServices
import UIKit
import RealmSwift


class DetailViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var populationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var collegeImageView: UIImageView!
    
let realm = try! Realm()
    var detailItem: College? {
        didSet {
            self.configureView()
        }
    }
     var changeImage = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        changeImage.delegate = self
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        changeImage.dismiss(animated: true) {
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.collegeImageView.image = selectedImage
        }
    }
    func configureView() {
        if let college = self.detailItem {
                if nameTextField != nil {
                    nameTextField.text = college.name
                    locationTextField.text = college.location
                    populationTextField.text = String(college.numberOfStudents)
                    websiteTextField.text = String(college.website)
                    collegeImageView.image = UIImage(data: college.image)
            }
        }
    }
    @IBAction func onTappedSubmit(_ sender: UIButton) {
        if let college = self.detailItem {
                try! realm.write ({
                college.name = nameTextField.text!
                college.location = locationTextField.text!
                college.numberOfStudents = Int(populationTextField.text!)!
                college.image = UIImagePNGRepresentation(collegeImageView.image!)!
                college.website = String(websiteTextField.text!)!
                })
            }
        }
    @IBAction func onTappedWebsiteLaunch(_ sender: UIButton) {
        let url = URL(string: websiteTextField.text!)!
        //url! <Exclamation mark was ommitted.
        UIApplication.shared.open(url, options: [:], completionHandler : nil)
    }
    @IBAction func onTappedImageChange(_ sender: UIButton) {
        changeImage.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(changeImage, animated: true, completion: nil)
        }
}
