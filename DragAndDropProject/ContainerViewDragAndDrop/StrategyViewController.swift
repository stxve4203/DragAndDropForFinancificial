//
//  StrategyViewController.swift
//  DragAndDropProject
//
//  Created by Stefan Weiss on 27.03.23.
//

import UIKit
import DragDropiOS

class StrategyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: DragDropCollectionView!

    var collectionModels: [Model] = []
    var dragDropManager: DragDropManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildCollectionModels()
        collectionView.dragDropDelegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func clearCellsDrogStatusOfCollectionView(){
        
        for cell in collectionView.visibleCells {
            
            if (cell as! DragDropCollectionViewCell).hasContent() {
                (cell as! DragDropCollectionViewCell).selectedStatus()
                continue
            }
            
            (cell as! DragDropCollectionViewCell).nomoralStatus()
        }
    }
    
    func buildCollectionModels(){
        for i in 0 ..< 8{
            let model = Model()
            model.collectionIndex = i
            
            collectionModels.append(model)
        }
    }

}


extension StrategyViewController: DragDropCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, touchBeginAtIndexPath indexPath: IndexPath) {
        
        clearCellsDrogStatusOfCollectionView()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canDragAtIndexPath indexPath: IndexPath) -> Bool {
        
        return collectionModels[indexPath.item].fruit != nil
        
    }
    func collectionView(_ collectionView: UICollectionView, dragInfoForIndexPath indexPath: IndexPath) -> AnyObject {
        
        let dragInfo = Model()
        dragInfo.collectionIndex = indexPath.item
        dragInfo.fruit = collectionModels[indexPath.item].fruit
        
        return dragInfo
    }
    
    func collectionView(_ collectionView: UICollectionView, canDropWithDragInfo dataItem: AnyObject, AtIndexPath indexPath: IndexPath) -> Bool {
        let dragInfo = dataItem as! Model
        
        let overInfo = collectionModels[indexPath.item]
        
        //        debugPrint("move over index: \(indexPath.item)")
        
        //drag source is mouse over item（self）
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
        
        return false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, dropOutsideWithDragInfo info: AnyObject) {
        clearCellsDrogStatusOfCollectionView()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, dragCompleteWithDragInfo dragInfo:AnyObject, atDragIndexPath dragIndexPath: IndexPath,withDropInfo dropInfo:AnyObject?) -> Void{
        if (dropInfo != nil){
            
            collectionModels[dragIndexPath.item].fruit = (dropInfo as! Model).fruit
        }else{
            collectionModels[dragIndexPath.item].fruit = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropCompleteWithDragInfo dragInfo:AnyObject, atDragIndexPath dragIndexPath: IndexPath?,withDropInfo dropInfo:AnyObject?,atDropIndexPath dropIndexPath:IndexPath) -> Void{
        
        collectionModels[dropIndexPath.item].fruit = (dragInfo as! Model).fruit
        
    }
    
    
    func collectionViewStopDropping(_ collectionView: UICollectionView) {
        
        clearCellsDrogStatusOfCollectionView()
        
        collectionView.reloadData()
    }
    
    func collectionViewStopDragging(_ collectionView: UICollectionView) {
        
        clearCellsDrogStatusOfCollectionView()
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = collectionModels[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DragDropCollectionViewCell", for: indexPath) as! DragDropCollectionViewCell
        
        cell.updateData(model)
        return cell
    }
    
    
}
