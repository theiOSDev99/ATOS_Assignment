//
//  ATGetPostsService.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation

protocol ATGetPostServiceProtocol {
    func didReceivedPosts(posts: [Posts])
}

struct PostArray: Decodable {
    let posts : [Posts]
}

class ATGetPostsService {
    var delgate: ATGetPostServiceProtocol?
    
    func getData() {
        //Check if posts already present in core data and return if post are already present
        let coreDataPostsModelArray = ATCoreDataPostsService.shared.getPosts()
        
        if coreDataPostsModelArray.count > 0 {
            if let del = self.delgate {
                let coreDataPostsModelArray = ATCoreDataPostsService.shared.getPosts()
                del.didReceivedPosts(posts: coreDataPostsModelArray)
            }
            print("Posts available in core data")
            return
        }
        
        //If posts are not present locally call API
        let networkBase = ATNetworkBase(baseRequest: AMBaseRequest(path: "posts", requestType: .get, dataDict: nil))
        networkBase.processRequest { response in
            switch response.result {
            case .success(let data):
                do {
                    var  modelArray: [Posts] = try JSONDecoder().decode([Posts].self, from: data as! Data)
                    //Saving received data to core data
                    ATCoreDataPostsService.shared.saveCoreDataChanges()
                }
                catch {
                    print("error in json")
                }
                if let del = self.delgate {
                    
                    let coreDataPostsModelArray = ATCoreDataPostsService.shared.getPosts()
                    del.didReceivedPosts(posts: coreDataPostsModelArray)
                }
            case .failure(let error):
                print(error)// Best practice - Error handling, skipped for assignment purpose
            }
        }
    }
}
