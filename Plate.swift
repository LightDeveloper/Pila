//
//  Plate.swift
//  Pila
//
//  Created by Dev2 on 07/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

typealias Plate = String

extension Plate: GameItem {
    var textPresentation: String {
        return self
    }

    func isCorrect(text: String) -> Bool {
        return text.lowercased() == self.lowercased()
    }
}
