//
//  SetupViewController.swift
//  Pila
//
//  Created by Dev2 on 29/04/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class SetupPlateViewController: UIViewController {
    
    @IBOutlet weak var tblFood: UITableView!
    @IBOutlet weak var txtfFood: UITextField!
    
    let plateSearcher = UISearchController(searchResultsController: nil)
    var platesFiltered: [Plate] = []
    
    deinit {
        debugPrint("Me muerooo setup plate 🥴")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let applicationDelegate = UIApplication.shared.delegate as? AppDelegate {
//                applicationDelegate.pruebaLocalizarDelegate()
//            
//            // Aquí puedo acceder a los valores AppDelegate
//        }
        
        tblFood.delegate = self
        tblFood.dataSource = self
        
        plateSearcher.searchResultsUpdater = self
        plateSearcher.obscuresBackgroundDuringPresentation = false
        tblFood.tableHeaderView = plateSearcher.searchBar
        
        let tercero = PlateFactory.shared[2]
        debugPrint("El tercer alimento es \(tercero)")
    }

    @IBAction func btnEditPressed(_ sender: UIBarButtonItem) {
        if tblFood.isEditing {
            tblFood.isEditing = false
            sender.title = "Edit"
        } else {
            tblFood.isEditing = true
            sender.title = "Done"
        }
    }
    
    @IBAction func btnAddPressed(_ sender: Any) {
        if let foodText = txtfFood.text,
            !foodText.isEmpty {
            PlateFactory.shared.insert(plate: foodText, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tblFood.insertRows(at: [indexPath], with: .automatic)
        }
    }
}

// Código para gestionar los filtros de búsquedas
extension SetupPlateViewController: UISearchResultsUpdating {
    
    func searchBarIsEmpty() -> Bool {
        return plateSearcher.searchBar.text?.isEmpty ?? true
        // Lo de arriba es equivalente a lo comentado de abajo
//        if let searchedText = plateSearcher.searchBar.text {
//            return !searchedText.isEmpty
//        }
//        return false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            debugPrint("Han escrito \(searchText)")
            platesFiltered = PlateFactory.shared.filter(text: searchText)
            
            tblFood.reloadData()
        }
        
    }
}

extension SetupPlateViewController: UITableViewDelegate {
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        debugPrint("Se pulsó la fila \(indexPath.row)")
    }
}

extension SetupPlateViewController: UITableViewDataSource {
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsEmpty() {
            return PlateFactory.shared.count
        } else {
            return platesFiltered.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "FoodTableViewCellIdentifier"
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if let foodTableViewCell = tableViewCell as? FoodTableViewCell {
            
//            let foodList = Food.shared.foodList
//            let foodName = foodList[indexPath.row]
//            foodTableViewCell.configure(info: foodName)
            
            let plate: Plate!
            if searchBarIsEmpty() {
                plate = PlateFactory.shared[indexPath.row]
            } else {
                plate = platesFiltered[indexPath.row]
            }
            foodTableViewCell.configure(info: plate)
            
            return foodTableViewCell
        }
        
        return tableViewCell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 3
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 4
    }
    
    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        let foodToMove = PlateFactory.shared.removePlateAt(index: sourceIndexPath.row)        
        PlateFactory.shared.insert(plate: foodToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        debugPrint("Editing style \(editingStyle) index \(indexPath)")
        
        switch editingStyle {
        case .delete:
            debugPrint("Quiero borrar la \(indexPath.row)")
            PlateFactory.shared.removePlateAt(index: indexPath.row)
            tblFood.deleteRows(at: [indexPath], with: .automatic)
        default:
            break;
        }
    }
}
