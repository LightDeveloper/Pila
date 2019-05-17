//
//  ViewController.swift
//  Pila
//
//  Created by Dev2 on 24/04/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var txtfUser: UITextField!
    @IBOutlet weak var stackViewGameItems: UIStackView!
    @IBOutlet weak var stackViewInput: UIStackView!
    
    var gameType: GameType!
    var factory: RandomFactory!
    var beater: GameBeater!
    var stack = Stack<GameItem>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("main viewDidLoad")
        // Do any additional setup after loading the view.
        txtfUser.becomeFirstResponder()
        
//        stack.delegate = self
        stack.pushedItem = { (item) in
            debugPrint("Pushed item \(item) 🤗")
        }
        
        beater.delegate = self
        beater.startWorking()
        
        (1...3).forEach { (_) in
            addItemToGame(factory.generateRandom())
        }
    }
    
    deinit {
        beater.stopWorking()
        debugPrint("Me muerooooo MainViewController ☠️")
    }
    
    
    // MARK: - Depuración de carga de vista
    override func viewWillAppear(_ animated: Bool) {
//        debugPrint("main viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        debugPrint("main viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        debugPrint("main viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        debugPrint("main viewDidDisappear")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
//        if let setupPlate = segue.destination as? SetupPlateViewController {
//        }
        
    }
    
    @IBAction func unwindFromSetup(unwindSegue: UIStoryboardSegue) {
//        if let setupPlate = unwindSegue.source as? SetupPlateViewController {
//        }
        
        beater.startWorking()
    }

    @IBAction func btnSetupPressed(_ sender: Any) {

//        if type(of: factory) == PlateFactory.self {
//            debugPrint("Estoy en plate factory 2")
//        }
//
//        if let _ = factory as? PlateFactory {
//            debugPrint("Estoy en plate factory 1")
//        }
//
        if gameType! == .plates {
            performSegue(withIdentifier: "segueToPlateSetup", sender: nil)
        } else if gameType! == .exercises {
            performSegue(withIdentifier: "segueToExerciseSetup", sender: nil)
        }
        
        beater.stopWorking()
    }
    
    // MARK: - Código normal
    func checkUserText() {
        guard let userText = txtfUser.text,
            !userText.isEmpty else {
            return
        }
        
        if let topItem = stack.head {

            let correct = topItem.isCorrect(text: userText)
            if correct {
                // Texto coincide, quito plato
                removeItemFromGame()
                checkWin()
            } else {
                addItemToGame(userText)
                checkLose()
            }
        } else {
            debugPrint("Aquí no debería de llegar")
        }
        
        txtfUser.text = ""
    }
    
    func removeItemFromGame() {
        if let view = stackViewGameItems.arrangedSubviews.first {
            view.removeFromSuperview()
        }
        stack.pop()
    }
    
    func addItemToGame(_ item: GameItem) {
        // Texto no coincide, castigo al usuario añadiendo su texto como plato
        let itemLabel = UILabel()
        itemLabel.text = item.textPresentation
        itemLabel.textAlignment = .center
        stackViewGameItems.insertArrangedSubview(itemLabel, at: 0) // Arriba
        stack.push(item: item)
    }
    
    func checkLose() {

        // Por numero de elementos
//        if stack.count < 12 {
//            return
//        }
        
        let spaceLeft = stackViewGameItems.frame.minY - stackViewInput.frame.maxY
        
        if spaceLeft > 20 {
            return
        }
 
        beater.stopWorking()
        showYouLose()
    }
    
    func showYouLose() {
        // He perdido
        txtfUser.resignFirstResponder()
        
        let alertLose = UIAlertController(title: "Game Over", message: "You lose", preferredStyle: .actionSheet)
        
        let aceptar = UIAlertAction(title: "Soy un paquete", style: .default) { (aceptar) in
            // TODO: Volver a empezar
            debugPrint("Vuelvo a empezar")
        }
        
        let cancelar = UIAlertAction(title: "Menú", style: .destructive)
        
        // Se pueden añadir de dos maneras
//        alertLose.actions = [aceptar, cancelar]
        alertLose.addAction(aceptar)
        alertLose.addAction(cancelar)
        self.present(alertLose, animated: true) {
            debugPrint("Alerta terminado de mostrarme")
        }

        // Ejemplo de como mostrar un view controller por código
//        let setup = self.storyboard?.instantiateViewController(withIdentifier: "SetupExerciseViewController")
//        self.present(setup!, animated: true, completion: nil)
    }
    
    func checkWin() {
        if stack.count > 0 {
            return
        }
        // He ganado
        view.backgroundColor = UIColor.green
        txtfUser.resignFirstResponder()
        beater.stopWorking()
    }
    
    @IBAction func btnSolvePressed(_ sender: Any) {
        checkUserText()
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkUserText()
        return false
    }
}
    
extension MainViewController: GameBeaterDelegate {
    
    func beater(_ beater: GameBeater, hasNewGameItem item: GameItem) {
        addItemToGame(item)
        checkLose()
    }
}

//extension MainViewController: StackDelegate {
//    func stack<Item>(_ stack: Stack<Item>, pushedItem item: Item) {
//        debugPrint("Se ha añadido \(item)")
//    }
//
//    func stack<Item>(_ stack: Stack<Item>, popedItem item: Item) {
//        debugPrint("Se ha quitado \(item)")
//    }
//
//}
