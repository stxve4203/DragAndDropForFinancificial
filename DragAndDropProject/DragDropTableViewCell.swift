//
//  DragDropTableViewCell.swift
//  DragAndDropProject
//
//  Created by Stefan Weiss on 24.03.23.
//

import UIKit

class DragDropTableViewCell: UITableViewCell {

        static let IDENTIFIER = "DRAG_DROP_TABLE_VIEW_CELL"
        
        @IBOutlet weak var contentLabel:UILabel!
        

        var model:Model!
        
        override func awakeFromNib() {
            backgroundColor = UIColor.white
            self.layer.borderColor = UIColor.blue.cgColor
            self.layer.borderWidth = 0.4
            
            var imageView: UIImageView!

            imageView = UIImageView(frame: CGRectMake(0, 0, 20, 20))
            imageView.image = UIImage(systemName: "arrow.turn.right.down")
            self.accessoryView = imageView
            
            self.selectionStyle = .none
        }

        
        func updateData(_ model:Model){
            self.model = model
            if model.fruit != nil {
                selectedStatus()
       
                contentLabel.text = model.fruit!.name!
            }else{
                nomoralStatus()
                contentLabel.text = nil
            }
        }
        
        func hasContent() -> Bool {
            return model.fruit != nil
        }
        
        func moveOverStatus(){
            backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        }
        
        func nomoralStatus(){
            backgroundColor = UIColor.white
            
        }
        
        func selectedStatus(){
           
        }

        
    }



