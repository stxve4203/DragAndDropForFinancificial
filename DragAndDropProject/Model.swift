//
//  Model.swift
//  DragAndDropProject
//
//  Created by Stefan Weiss on 23.03.23.
//

import Foundation

class Model {
    var collectionIndex:Int? //not use now
    var tableIndex:Int? //not use now
    var fruit:Fruit?
}


class Fruit {
    var id:Int!
    var name:String?
    var imageName:String?
    init(id:Int,name:String,imageName:String) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }
}
