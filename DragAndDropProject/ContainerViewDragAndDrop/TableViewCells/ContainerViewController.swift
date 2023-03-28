//
//  ContainerViewController.swift
//  DragAndDropProject
//
//  Created by Stefan Weiss on 27.03.23.
//

import UIKit
import DragDropiOS

class ContainerViewController: UIViewController {
    
    var dragDropManager: DragDropManager!
    
    @IBOutlet weak var strategyView: UIView!
    @IBOutlet weak var itemView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemVC = storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as? ItemViewController
        print(itemVC?.collectionView)
        
            
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var strategyCollectionView: DragDropCollectionView!
        
        if segue.identifier == "StrategySegue" {
            if let strategyVC = segue.destination as? StrategyViewController {
                strategyVC.collectionView = strategyCollectionView
                strategyVC.dragDropManager = dragDropManager
                print(strategyCollectionView)
            }
        
        }
        
        if segue.identifier == "ItemSegue" {
            if let itemVC = segue.destination as? ItemViewController {
                itemVC.dragDropManager = self.dragDropManager
            }
        }
    }

}
