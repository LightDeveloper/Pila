//
//  GameSelectorViewController.swift
//  Pila
//
//  Created by Dev2 on 08/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class GameSelectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    // TODO: - Navigation
    // FIXME: - No funciona
    // !!!: Esto está mal
    // ???: No lo entiendo

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        
        if let mainViewController = segue.destination as? MainViewController,
            let segueId = segue.identifier {
            
                switch segueId {
                case "seguePlates":
                    mainViewController.gameType = .plates
                    mainViewController.factory = PlateFactory.shared
                    mainViewController.beater = GameBeater(itemFactory: PlateFactory.shared)
                case "segueExercises":
                    mainViewController.gameType = .exercises
                    mainViewController.factory = ExerciseFactory.shared
                    mainViewController.beater = GameBeater(itemFactory: ExerciseFactory.shared)
                default:
                    debugPrint("Error esto no se puede dar")
                }
            
        }
        
    }
    

}
