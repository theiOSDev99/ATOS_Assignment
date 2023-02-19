//
//  ATLoginViewModel.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation
 
class ATLoginViewModel {
    
    var emailId: ATObservable<String> = ATObservable(value: "")
    var password: ATObservable<String> = ATObservable(value: "")
    
    private let validPasswordMinLength = 8
    private let validPasswordMaxLength = 15
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let validEmail = emailTest.evaluate(with: emailId.value)
        
        return validEmail
    }
    
    func validatePassword() -> Bool {
        var validPassword = false
        let pswdCount = password.value?.count ?? 0
        if pswdCount >= validPasswordMinLength && pswdCount <= validPasswordMaxLength {
            validPassword = true
        }
        return validPassword
    }
}
