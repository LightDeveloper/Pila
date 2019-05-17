//
//  Food.swift
//  Pila
//
//  Created by Dev2 on 29/04/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

class PlateFactory {
    
    static let shared = PlateFactory()
    
    private let plateListDefault = ["pizza", "sushi", "lasagna", "solomillo", "patatas", "ensalada", "pato", "rabo de toro", "lentejas", "hamburguesa", "espagueti", "paella", "fabada", "cocido", "tequeños"]

    private var plateList: [Plate] = []
    
    init() {
        loadFromUserDefaults()
    }
    
    var count: Int {
        return plateList.count
    }
    
    func filter(text: String) -> [Plate] {
        return plateList.filter { (plateText) -> Bool in
            plateText.lowercased().hasPrefix(text.lowercased())
        }
    }
    
    func insert(plate: String, at index: Int) {
        plateList.insert(plate, at: index)
    }
    
    @discardableResult
    func removePlateAt(index: Int) -> Plate {
        return plateList.remove(at: index)
    }
    
    subscript(index: Int) -> Plate {
        get {
            return plateList[index]
        }
        set(newValue) {
            plateList[index] = newValue
        }
    }
}

// Save to User defaults
extension PlateFactory {
    
    func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        plateList = defaults.stringArray(forKey: "plateList") ?? plateListDefault
    }
    
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(plateList, forKey: "plateList")
    }
    
}

extension PlateFactory: RandomFactory {
    
    func generateRandom() -> GameItem {
        let index = Int.random(in: 0 ..< plateList.count)
        return plateList[index]
    }
    
}
