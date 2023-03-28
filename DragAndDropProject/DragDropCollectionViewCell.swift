//
//  DragDropCollectionViewCell.swift
//  DragAndDropProject
//
//  Created by Stefan Weiss on 23.03.23.
//

import UIKit

class DragDropCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var arrowRight: UIImageView!
    
    var model: Model!

    func updateData(_ model:Model){
        self.model = model
        if model.fruit != nil {
            selectedStatus()
            label.text = model.fruit?.name!
            for x in 0..<3 {
                if arrowRight != nil {
                    arrowRight.isHidden = false
                }
            }
        }else{
            nomoralStatus()
            if arrowRight != nil {
                arrowRight.isHidden = true
            }
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

