//
//  ItemCell.swift
//  DragAndDropProject
//
//  Created by Stefan Weiss on 27.03.23.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var model: Model!

    func updateData(_ model:Model){
        self.model = model
        if model.fruit != nil {
            selectedStatus()
            label.text = model.fruit?.name!
            
        }else{
            nomoralStatus()
            label.text = "n.A."
        }
    }
    
    func hasContent() -> Bool {
        return model.fruit != nil
    }
    
    func moveOverStatus(){
        setColor(color: UIColor.orange.withAlphaComponent(0.5))

    }
    
    func nomoralStatus(){
        setColor()

    }
    
    func selectedStatus(){
        setColor(color: UIColor.blue.withAlphaComponent(0.5))
    }
    
    private func setColor(color: UIColor? = nil) {

        layer.masksToBounds = false
        layer.backgroundColor = color?.cgColor ?? UIColor.systemBlue.cgColor
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 20
        self.label.textColor = .white
    }
}
