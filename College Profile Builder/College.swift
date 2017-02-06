//
//  College.swift
//  College Profile Builder
//
//  Created by Tconti on 2/6/17.
//  Copyright © 2017 Conti Inc. All rights reserved.
//

import UIKit

class College: NSObject {

    var name = String()
    var location = String()
    var numberOfStudents = Int()
    var image = Data()
    
    convenience init(name : String, location : String, numberOfStudents : Int, image : Data){
        self.init()
        self.name = name
        self.location = location
        self.numberOfStudents = numberOfStudents
        self.image = image
    }
    
}
