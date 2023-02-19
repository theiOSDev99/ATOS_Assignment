//
//  ATCoreDataPostsService.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation
import CoreData

class ATCoreDataPostsService {
    static let shared = ATCoreDataPostsService()
    
    private init() {}
    
    //Best practice - try catch and error handlign skipped for assingment purpose
    func getPosts() -> [Posts] {
        let request = NSFetchRequest<Posts>(entityName: "Posts")
        let data =  try? ATCoreDataManeger.shared.persistentContainer.viewContext.fetch(request)
        return data ?? []
    }
    
    func getFavouritePosts() -> [Posts] {
        let request = NSFetchRequest<Posts>(entityName: "Posts")
        request.predicate = NSPredicate(format: "isFavourite == 1")
        let data =  try? ATCoreDataManeger.shared.persistentContainer.viewContext.fetch(request)
        return data ?? []
    }

    func saveCoreDataChanges() {
        ATCoreDataManeger.shared.saveContext()
    }
}
