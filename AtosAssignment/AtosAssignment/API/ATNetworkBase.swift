//
//  ATNetworkBase.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation
import UIKit

enum AMRequestType: Int {
    case get = 1
    case post = 2
}

struct AMBaseRequest {
    var path: String = ""
    var requestType: AMRequestType
    var dataDict: [String: String]?
}

enum AMNetworkBaseError: Error {
    case apiFailure
    case apiInvalid
    case dataError
    case parseFail
    case networkError
    case unknown
}

struct AMBaseResponse {
    var result: Result<Any?, AMNetworkBaseError>
}

class ATNetworkBase {
    
    private let baseUrl = "https://jsonplaceholder.typicode.com"
    private var urlStr: String
    private var request: AMBaseRequest
    
    private init?() {
        return nil
    }
    
    init(baseRequest: AMBaseRequest) {
        request = baseRequest
        print("AMNetworkBase: init")
        switch request.requestType {
        case .get:
            urlStr =  baseUrl + "/" + request.path
            print("AMNetworkBase: constructUrlFor: .get - URL string -\(urlStr)-")

        case .post:
            urlStr = baseUrl + "/" + request.path
            print("AMNetworkBase: constructUrlFor: .post - URL string -\(urlStr)-")
        }
    }
    
    func processRequest(completion: @escaping ((_ response: AMBaseResponse) -> Void)){
        print("ATNetworkBase: processRequest")
        guard let url = URL(string: urlStr) else {
            print("AMNetworkBase: processRequest - Couldn't create URL")
            completion(AMBaseResponse(result: .failure(.apiInvalid)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error  in
            if error != nil {
                completion(AMBaseResponse(result: .failure(.apiFailure)))
                return
            }
            
            if let theData = data {
                completion(AMBaseResponse(result: .success(theData)))
                return
            } else {
                completion(AMBaseResponse(result: .failure(.dataError)))
            }
        }
        dataTask.resume()
    }
}
    

