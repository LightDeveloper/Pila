//
//  Exercise.swift
//  Pila
//
//  Created by Dev2 on 07/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct Exercise {
    let first: Int
    let operation: Operation
    let second: Int
    let result: Int
    
    init(first: Int, operation: Operation, second: Int) {
        self.first = first
        self.operation = operation
        self.second = second
        self.result = operation.result(first: first, second: second)
    }
    
    var isValid: Bool {
        return operation.isValid(first: first, second: second)
    }
}

extension Exercise: GameItem {
    var textPresentation: String {
        return "\(first) \(operation.rawValue) \(second)"
    }
    
    func isCorrect(text: String) -> Bool {
        return self.result.description == text
    }
}

extension Exercise {
    enum Operation: String {
        case add = "+", sub = "-", mul = "*", div = "/"
        
        static var random: Operation {
            let operations: [Operation] = [.add, .sub, .mul, .div]
            let index = Int.random(in: 0 ..< operations.count)
            return operations[index]
        }
        
        var randomByOperation: (first: Int, second: Int) {
            let maxValue = UserDefaults.standard.double(forKey: "maxValue")
            let maxValueInt = Int(maxValue)
            
            switch self {
            case .add, .mul:
                let first = Int.random(in: 0 ... maxValueInt)
                let second = Int.random(in: 0 ... maxValueInt)
                return (first, second)
            case .sub:
                let first = Int.random(in: 0 ... maxValueInt)
                let second = Int.random(in: 0 ... maxValueInt)
                return (first, second)
            case .div:
                let first = Int.random(in: 0 ... maxValueInt)
                let second = Int.random(in: 1 ... maxValueInt)
                let result = first * second
                return (result, second)
            }
        }

        func isValid(first: Int, second: Int) -> Bool {
            
            switch self {
            case .add, .mul:
                return true
            case .sub:
                let allowNegatives = UserDefaults.standard.bool(forKey: "allowNegatives")
                if allowNegatives {
                    return true
                } else {
                    return first - second > 0
                }
            case .div:
                return first % second == 0
            }
        }
        
        func result(first: Int, second: Int) -> Int {
            switch self {
            case .add:
                return first + second
            case .sub:
                return first - second
            case .mul:
                return first * second
            case .div:
                return first / second
            }
        }
    }
}
