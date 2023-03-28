//
//  MultipleCollectionViewController.swift
//  DragAndDropProject
//
//  Created by Stefan Weiss on 27.03.23.
//

import UIKit
import DragDropiOS

class MultipleCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var itemCollectionView: DragDropCollectionView!
    @IBOutlet weak var strategyCollectionView: DragDropCollectionView!
    
    var pinchGesture = UIPinchGestureRecognizer()
    var panGesture = UIPanGestureRecognizer()
    
    var collectionModels: [Model] = []
    var strategyModels: [Model] = []
    var strategyArray: [String] = []
    var dropManager: DragDropManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildCollectionModels()
        buildTableViewModels()
        
        
        self.pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_ :)))
        self.pinchGesture.delegate = self
        self.strategyCollectionView.addGestureRecognizer(pinchGesture)
        
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwiping(_ :)))
        self.panGesture.delegate = self
        self.strategyCollectionView.addGestureRecognizer(self.panGesture)
        
        
        
        
        self.itemCollectionView.dragDropDelegate = self
        self.strategyCollectionView.dragDropDelegate = self
        dropManager = DragDropManager(canvas: self.view, views: [self.itemCollectionView, self.strategyCollectionView])

    }
    
    @IBAction func deletePressed(_ sender: Any) {
        
        removeStrategy()
        
    }
    
    private func removeStrategy() {
        self.collectionModels.removeAll()
        self.strategyModels.removeAll()
        
        buildTableViewModels()
        buildCollectionModels()
        self.itemCollectionView.reloadData()
        self.strategyCollectionView.reloadData()
    }
    
    @objc func handleSwiping(_ sender: UIPanGestureRecognizer) {
            if sender.state == .began || sender.state == .changed {

                let translation = sender.translation(in: self.view)
                // note: 'view' is optional and need to be unwrapped
                sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
                sender.setTranslation(CGPoint.zero, in: self.view)
            }
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer? = nil) {
                
        sender?.view?.transform = (sender?.view?.transform.scaledBy(x: sender!.scale, y: sender!.scale))!
        
        sender?.scale = 1.0
    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.itemCollectionView {
            let model = collectionModels[indexPath.item]
            let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DragDropCollectionViewCell", for: indexPath) as? DragDropCollectionViewCell
            itemCell?.updateData(model)
            return itemCell!
        } else {
            let model = strategyModels[indexPath.item]

            let strategyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DragDropCollectionViewCell", for: indexPath) as? DragDropCollectionViewCell
            strategyCell?.updateData(model)
            return strategyCell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.itemCollectionView {
            return collectionModels.count
        }
        return strategyModels.count
        
    }

    func buildCollectionModels(){
        for i in 0 ..< 8{
            let model = Model()
            model.collectionIndex = i
            if i == 0 {
                let fruit = Fruit(id: 1, name: "Avocado",imageName:"Avocado")
                model.fruit = fruit
            }
            if i == 1 {
                let fruit = Fruit(id: 2, name: "Durian",imageName:"Durian")
                model.fruit = fruit
            }
            if i == 2{
                let fruit = Fruit(id: 3, name: "Mangosteen",imageName:"Mangosteen")
                model.fruit = fruit
            }
            if i == 3 {
                let fruit = Fruit(id: 4, name: "Beere", imageName: "Blabla")
                model.fruit = fruit
            }
            
            if i == 4 {
                let fruit = Fruit(id: 5, name: "Erdbeere", imageName: "Erdbeere")
                model.fruit = fruit
            }
            
            if i == 5 {
                let fruit = Fruit(id: 6, name: "Apple", imageName: "Apple")
                model.fruit = fruit
            }
            
            if i == 6 {
                let fruit = Fruit(id: 7, name: "Orange", imageName: "Orange")
                model.fruit = fruit
            }
            
            if i == 7 {
                let fruit = Fruit(id: 8, name: "Goku", imageName: "Goku")
                model.fruit = fruit
            }
            
            if i == 8 {
                let fruit = Fruit(id: 9, name: "Watermelon", imageName: "Watermelon")
                model.fruit = fruit
            }
            
            collectionModels.append(model)
        }
    }
    
    func buildTableViewModels() {
        for j in 0 ..< 8{
            let m = Model()
            m.tableIndex = j
            strategyModels.append(m)
        }
    }
}

extension MultipleCollectionViewController: DragDropCollectionViewDelegate {
    /// Collection View
    func collectionView(_ collectionView: UICollectionView, touchBeginAtIndexPath indexPath: IndexPath) {
        
        if collectionView == self.itemCollectionView {
            clearCellsDrogStatusOfCollectionView()
        } else {
            clearCellsDrogStatusOfStrategyCollectionView()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canDragAtIndexPath indexPath: IndexPath) -> Bool {
        if collectionView == self.itemCollectionView {
            return collectionModels[indexPath.item].fruit != nil
        } else {
            return strategyModels[indexPath.item].fruit != nil
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, dragInfoForIndexPath indexPath: IndexPath) -> AnyObject {
        
        if collectionView == self.itemCollectionView {
            let dragInfo = Model()
            
            dragInfo.collectionIndex = indexPath.item
            dragInfo.fruit = collectionModels[indexPath.item].fruit
            
            return dragInfo
        } else {
            let dragInfo = Model()
            dragInfo.collectionIndex = indexPath.item
            dragInfo.fruit = strategyModels[indexPath.item].fruit
            return dragInfo
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, canDropWithDragInfo dataItem: AnyObject, AtIndexPath indexPath: IndexPath) -> Bool {
        if collectionView == self.itemCollectionView {
            
            let dragInfo = dataItem as! Model
            
            let overInfo = collectionModels[indexPath.item]

            if overInfo.fruit != nil{
                return false
            }
            
            clearCellsDrogStatusOfCollectionView()
            
            for _ in collectionView.visibleCells{
                
                
                if overInfo.fruit == nil {
                    let cell = collectionView.cellForItem(at: indexPath) as! DragDropCollectionViewCell
                    cell.moveOverStatus()
                    debugPrint("can drop in . index = \(indexPath.item)")
                    
                    return true
                }else{
                    debugPrint("can't drop in. index = \(indexPath.item)")
                }
            }
        } else {
            let dragInfo = dataItem as! Model
            
            let overInfo = strategyModels[indexPath.item]

            if overInfo.fruit != nil{
                return false
            }
            
            clearCellsDrogStatusOfStrategyCollectionView()
            
            for cell in strategyCollectionView.visibleCells{
                
                    if overInfo.fruit == nil {
                        let cell = strategyCollectionView.cellForItem(at: indexPath) as! DragDropCollectionViewCell
                        cell.moveOverStatus()
                        debugPrint("can drop in . index = \(indexPath.item)")
                        
                        return true
                    }else{
                        debugPrint("can't drop in. index = \(indexPath.item)")
                    }
            }
        }
        return false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, dropOutsideWithDragInfo info: AnyObject) {
        if collectionView == self.itemCollectionView {
            clearCellsDrogStatusOfCollectionView()
        } else {
            clearCellsDrogStatusOfStrategyCollectionView()
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, dragCompleteWithDragInfo dragInfo:AnyObject, atDragIndexPath dragIndexPath: IndexPath,withDropInfo dropInfo:AnyObject?) -> Void{
        
        if (dropInfo != nil){
            if collectionView == itemCollectionView {
                collectionModels[dragIndexPath.item].fruit = (dropInfo as! Model).fruit
            } else {
                strategyModels[dragIndexPath.item].fruit = (dropInfo as! Model).fruit
            }
        }else{
            collectionModels[dragIndexPath.item].fruit = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropCompleteWithDragInfo dragInfo:AnyObject, atDragIndexPath dragIndexPath: IndexPath?,withDropInfo dropInfo:AnyObject?,atDropIndexPath dropIndexPath:IndexPath) -> Void{
        
        if collectionView == self.itemCollectionView {
            collectionModels[dropIndexPath.item].fruit = (dragInfo as! Model).fruit
        } else {
            
            strategyModels[dropIndexPath.item].fruit = (dropInfo as! Model).fruit
            /// Append items in dropping area
            strategyArray.append((strategyModels[dropIndexPath.item].fruit?.name)!)
            
            /// Removing Duplicate Items in Array
            var duplicateArray = strategyArray.removeDuplicates()
            strategyArray = duplicateArray

            print(strategyArray)
            
        }
        
    }
    
    
    func collectionViewStopDropping(_ collectionView: UICollectionView) {
        
        if collectionView == self.itemCollectionView {
            clearCellsDrogStatusOfCollectionView()
        } else {
            clearCellsDrogStatusOfStrategyCollectionView()
        }
        
        collectionView.reloadData()
    }
    
    func collectionViewStopDragging(_ collectionView: UICollectionView) {
        
        if collectionView == self.itemCollectionView {
            clearCellsDrogStatusOfCollectionView()
        } else {
            clearCellsDrogStatusOfStrategyCollectionView()
        }
        
        collectionView.reloadData()
        
    }

    func clearCellsDrogStatusOfStrategyCollectionView(){
        
            for cell in strategyCollectionView.visibleCells {
                
                if (cell as! DragDropCollectionViewCell).hasContent() {
                    (cell as! DragDropCollectionViewCell).selectedStatus()
                    continue
                }
                
                (cell as! DragDropCollectionViewCell).nomoralStatus()
            }
    }
    
    
    func clearCellsDrogStatusOfCollectionView(){
        
            for cell in itemCollectionView.visibleCells{
                
                if (cell as! DragDropCollectionViewCell).hasContent() {
                    (cell as! DragDropCollectionViewCell).selectedStatus()
                    continue
                }
                
                (cell as! DragDropCollectionViewCell).nomoralStatus()
            }
    }
}
