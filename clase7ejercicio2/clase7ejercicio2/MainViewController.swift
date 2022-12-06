//
//  ViewController.swift
//  clase7ejercicio2
//
//  Created by Mac on 2/12/22.
//

import UIKit

class MainViewController: UIViewController {
    
    private struct Constant {
        static let alertTitle = "Error"
        static let alertServerMessage = "El servidor no pudo guardar la información"
        static let alertEmptyFieldsMessage = "Campos Vacios"
        static let segueToUserView = "goToUserViewController"
        static let alertCancelAction = "Cancelar"
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var documentTextField: UITextField!
    @IBOutlet weak var idTypePopUpButton: UIButton!
    @IBOutlet weak var sexTextField: UITextField!
    
    private var userName = ""
    private var userId = ""
    private var userSex = ""
    private var userIdType = ""
    private var emptyFormFields = false
    private var randomInt = 1
    private var serverError = false
    private var alertError = UIAlertController()
    private var cancelAction = UIAlertAction()
    private var alertErrorMessage = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIdTypePopUpButton()
    }
    
    private func setIdTypePopUpButton() {
        setPopUpMenu()
        userIdType = idTypePopUpButton.titleLabel?.text ?? ""
    }
    
    private func setPopUpMenu() {
        idTypePopUpButton.menu = UIMenu(children : [createChildAction("CC"),createChildAction("TI")])
    }
    
    private func createChildAction(_ title : String) -> UIAction {
        return UIAction(title: title, handler: createOptionHandler())
    }
    
    private func createOptionHandler() -> (UIAction) -> () {
        return {(action : UIAction) in self.userIdType = action.title}
    }
    
    @IBAction func sendDataButtonPressed() {
        updateRandomInt()
        checkServer()
        saveDataFromForm()
        checkFormFields()
        validateData()
    }
    
    private func updateRandomInt() {
        randomInt = Int.random(in: 1...3)
    }
    
    private func checkServer() {
        return serverError = randomInt == 1
    }
    
    private func saveDataFromForm() {
        userName = nameTextField.text ?? ""
        userId = documentTextField.text ?? ""
        userSex = sexTextField.text ?? ""
    }
    
    private func checkFormFields() {
        emptyFormFields = userName.isEmpty || userId.isEmpty || userSex.isEmpty
    }
    
    private func validateData() {
        if emptyFormFields  {
            alertErrorMessage = Constant.alertEmptyFieldsMessage
            presentAlertError()
        } else if serverError {
            alertErrorMessage = Constant.alertServerMessage
            presentAlertError()
        } else {
            goToUserView()
        }
    }
    
    private func presentAlertError() {
        createErrorAlert()
        setupAlertAction()
        addAlertAction()
        presentAlert()
    }
    
    private func createErrorAlert() {
        alertError = UIAlertController(title: Constant.alertTitle, message: alertErrorMessage, preferredStyle: .alert)
    }
    
    private func setupAlertAction() {
        cancelAction = UIAlertAction(title: Constant.alertCancelAction, style: .cancel)
    }
    
    private func addAlertAction() {
        alertError.addAction(cancelAction)
    }
    
    private func presentAlert() {
        present(alertError, animated: true)
    }
    
    private func goToUserView() {
        performSegue(withIdentifier: Constant.segueToUserView, sender: self)
    }
    
}

