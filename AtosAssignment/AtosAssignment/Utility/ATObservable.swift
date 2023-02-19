//
//  ATObservable.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation


//I am using closure based MVVM binding
class ATObservable <T> {
    var value: T? {
        didSet {
            self.observe?(value)
        }
    }
    
    init (value: T) {
        self.value = value
    }
    
    private var observe: ((T?) -> ())?
    
    func addObservale(completionHandler: @escaping (T?) -> ()) {
        observe = completionHandler
    }
}
