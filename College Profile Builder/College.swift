//
//  College.swift
//  College Profile Builder
//
//  Created by Tconti on 2/6/17.
//  Copyright © 2017 Conti Inc. All rights reserved.
//

import UIKit
import SafariServices
import UIKit
import RealmSwift

class College: Object {

    dynamic var name = String()
    dynamic var location = String()
    dynamic var numberOfStudents = Int()
    dynamic var image = Data()
    dynamic var website = String()
    
    convenience init(name : String, location : String, numberOfStudents : Int, image : Data, website: String){
        self.init()
        self.name = name
        self.location = location
        self.numberOfStudents = numberOfStudents
        self.image = image
        self.website = website
}
}
