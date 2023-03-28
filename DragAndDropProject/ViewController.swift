//
//  ViewController.swift
//  DragAndDropProject
//
//  Created by Stefan Weiss on 23.03.23.
//

import UIKit
import DragDropiOS

class ViewController: UIViewController, DragDropCollectionViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionModels:[Model] = [Model]()
    var tableModels: [Model] = [Model]()
    var dragDropManager: DragDropManager!
    var strategyArray: [String] = []

    
    @IBOutlet weak var tableView: DragDropTableView!
    @IBOutlet weak var droppableCollectionView: DragDropCollectionView!
    @IBOutlet weak var removeStrategyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildCollectionModels()
        buildTableViewModels()
        tableView.dragDropDelegate = self
        droppableCollectionView.dragDropDelegate = self
        droppableCollectionView.bounces = false
        dragDropManager = DragDropManager(canvas: self.view, views: [droppableCollectionView, tableView])
        
        self.tableView.separatorStyle = .none
    }
    
    func buildTableViewModels() {
        for j in 0 ..< 8{
            let m = Model()
            m.tableIndex = j
            tableModels.append(m)
        }
    }
    
    @IBAction func removeStrategyPressed(_ sender: Any) {
        removeStrategy()
        
    }
    
    private func removeStrategy() {
        self.tableModels.removeAll()
        self.collectionModels.removeAll()
        buildTableViewModels()
        buildCollectionModels()
        self.tableView.reloadData()
        self.droppableCollectionView.reloadData()
    }
    
    
    
    /// Collection View
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

    func clearCellsDrogStatusOfCollectionView(){
        
        for cell in droppableCollectionView.visibleCells{
            
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = collectionModels[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DropCollectionViewCell", for: indexPath) as! DragDropCollectionViewCell
        
        cell.updateData(model)
        return cell
    }
}


/// Tableview delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = tableModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DragDropTableViewCell", for: indexPath) as! DragDropTableViewCell
        
        cell.updateData(model)
        return cell
        
    }
    
    func clearCellsDrogStatusOfTableView(){
        
        for cell in tableView.visibleCells{
            
            if (cell as! DragDropTableViewCell).hasContent() {
                (cell as! DragDropTableViewCell).selectedStatus()
                continue
            }
            
            (cell as! DragDropTableViewCell).nomoralStatus()
            
            
        }
        
    }
    
}
