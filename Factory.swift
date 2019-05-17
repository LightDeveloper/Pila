//
//  Factory.swift
//  Pila
//
//  Created by Dev2 on 07/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

protocol GameItem {
    var textPresentation: String { get }
    func isCorrect(text: String) -> Bool
}

protocol RandomFactory: class {
    func generateRandom() -> GameItem
}
