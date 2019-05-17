//
//  ExerciseFactory.swift
//  Pila
//
//  Created by Dev2 on 29/04/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

class ExerciseFactory {
    
    static let shared = ExerciseFactory()

    var exercises: [Exercise] = []
    
    static func isCorrect(userText: String, exercise: Exercise) -> Bool {
        return exercise.isCorrect(text: userText)
    }
    
    func insert(exercise: Exercise, at index: Int) {
        exercises.insert(exercise, at: index)
    }
    
    func removeExerciseAt(index: Int) {
        exercises.remove(at: index)
    }
    
    subscript(index: Int) -> Exercise {
        get {
            return exercises[index]
        }
        set(newValue) {
            exercises[index] = newValue
        }
    }
}

extension ExerciseFactory: RandomFactory {
    func generateRandom() -> GameItem {

        var exercise: Exercise!
        let operation = Exercise.Operation.random
        repeat {
            let (first, second) = operation.randomByOperation
            exercise = Exercise(first: first, operation: operation, second: second)
        } while !exercise.isValid
        
        return exercise
    }
}

