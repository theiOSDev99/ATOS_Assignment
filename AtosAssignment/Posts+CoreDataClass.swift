//
//  Posts+CoreDataClass.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//
//

import Foundation
import CoreData

//Reference : https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/

public class Posts: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
      case id, userId, title, body
    }
    
    required convenience public init(from decoder: Decoder) throws {
        self.init(context: ATCoreDataManeger.shared.persistentContainer.viewContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.userId = try container.decode(Int64.self, forKey: .userId)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
      }
}
