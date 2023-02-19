//
//  ATLoginViewController.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation
import UIKit
import CoreData

class ATLoginViewController: UITableViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelEmailErrorMessage: UILabel!
    @IBOutlet weak var labelPasswordErrorMessage: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    
    
    let viewModel = ATLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonLogin.isEnabled = false
        configureTextField()
        configureErrorLabels()
        
        viewModel.emailId.addObservale { email in
            self.validateTextFieldsAndEnableLogin()
        }
        
        viewModel.password.addObservale { password in
            self.validateTextFieldsAndEnableLogin()
        }
    }
    
    private func configureTextField() {
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
        textFieldEmail.addTarget(self, action: #selector(ATLoginViewController.textFieldDidChange(_:)),
                                  for: .editingChanged)
        textFieldPassword.addTarget(self, action: #selector(ATLoginViewController.textFieldDidChange(_:)),
                                  for: .editingChanged)
    }
    
    private func configureErrorLabels() {
        labelEmailErrorMessage.text = "Invalid Email" //Best practice - Using localisable skipped for assignment purpose
        labelEmailErrorMessage.isHidden = true
        
        labelPasswordErrorMessage.text = "Password should be within 8 to 15 char"
        labelPasswordErrorMessage.isHidden = true
        
    }
    
    private func validateTextFieldsAndEnableLogin() {

        let validEmail = viewModel.validateEmail()
        labelEmailErrorMessage.isHidden = validEmail ? true : false
        
        let validPassword = viewModel.validatePassword()
        labelPasswordErrorMessage.isHidden = validPassword ? true : false
        
        if validEmail && validPassword {
            buttonLogin.isEnabled = true
        } else {
            buttonLogin.isEnabled = true
        }
    }
    
    
    @IBAction func clickedLogInButton(_ sender: Any) {
        print("clickedLogInButton")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let homeTabVC = sb.instantiateViewController(withIdentifier: "ATHomeTabViewController" ) //Best practie is to use string for constants
        UIApplication.shared.keyWindow?.rootViewController = homeTabVC
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}

extension ATLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == textFieldEmail {
            viewModel.emailId.value = textField.text
        } else if textField == textFieldPassword {
            viewModel.password.value = textField.text
        }
    }
}
