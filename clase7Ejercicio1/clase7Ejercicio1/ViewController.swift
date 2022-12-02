//
//  ViewController.swift
//  clase7Ejercicio1
//
//  Created by Mac on 2/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    private struct Constant {
        static let alertTittle = ""
        static let alertMessage = "Ingresar Documento"
        static let alertAccessAction = "Ingresar"
        static let alertCancelAction = "Cancelar"
        static let textFieldPlaceholder = "Documento"
        static let segueToStudentView = "goToStudentView"
        static let segueToProfessorView = "goToProfessorView"
        static let errorTittle = "Error"
        static let errorIdNotFound = "No existe Documento"
        static let errorIdIsEmpty = "Campo Vacio"
        static let studentDocuments = ["10","11","12"]
        static let professorDocuments = ["20","21","22"]
    }
    
    var alertToAccess = UIAlertController()
    var alertError = UIAlertController()
    var accessAction = UIAlertAction()
    var cancelAction = UIAlertAction()
    var errorMessage = ""
    var document = ""
    var documentIsEmpty = false
    var studentDocument = false
    var professorDocument = false
    
    @IBAction func onAccessButtonTapped() {
        createAlert()
        setupAlertActions()
        addAlertAction(alertToAccess,accessAction)
        addAlertAction(alertToAccess,cancelAction)
        addTextFieldToAlert()
        present(alertToAccess, animated: true)
    }
    
    private func createAlert() {
        alertToAccess = UIAlertController(title: Constant.alertTittle, message: Constant.alertMessage, preferredStyle: .alert)
    }
    
    private func setupAlertActions() {
        accessAction = UIAlertAction(title: Constant.alertAccessAction, style: .default) { _ in
            self.obtainDocument()
            self.validateDocument()
            self.processAccessAction()
        }
        cancelAction = UIAlertAction(title: Constant.alertCancelAction, style: .cancel)
    }
    
    private func addAlertAction(_ alert: UIAlertController,_ action : UIAlertAction) {
        alert.addAction(action)
    }
    
    private func addTextFieldToAlert() {
        alertToAccess.addTextField { textField in
            textField.placeholder = Constant.textFieldPlaceholder
        }
    }
    
    private func obtainDocument() {
        guard let textFields = alertToAccess.textFields else { return }
        document = textFields[0].text ?? ""
    }
    
    private func validateDocument() {
        documentIsEmpty = document.isEmpty
        studentDocument = reviewDocument(Constant.studentDocuments)
        professorDocument = reviewDocument(Constant.professorDocuments)
        
    }
    
    private func reviewDocument(_ documentsArray: [String]) -> Bool {
        var documentExist = false
        for i in 0..<documentsArray.count {
            if document == documentsArray[i] {
                documentExist = true
            }
        }
        return documentExist
    }
    
    private func processAccessAction() {
        if professorDocument {
            navigateWithSegue(Constant.segueToProfessorView)
        } else if studentDocument {
            navigateWithSegue(Constant.segueToStudentView)
        } else if documentIsEmpty {
            errorMessage = Constant.errorIdIsEmpty
            presentErrorAlert()
        } else {
            errorMessage = Constant.errorIdNotFound
            presentErrorAlert()
        }
    }
    
    private func navigateWithSegue(_ segue: String) {
        performSegue(withIdentifier: segue, sender: self)
    }
    
    private func presentErrorAlert() {
        alertError = UIAlertController(title: Constant.errorTittle, message: errorMessage, preferredStyle: .alert)
        addAlertAction(alertError, cancelAction)
        present(alertError, animated: true)
    }
}

