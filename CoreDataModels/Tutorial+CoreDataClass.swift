//
//  Tutorial+CoreDataClass.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Tutorial)
public class Tutorial: NSManagedObject, Codable{
    
//    init(title:String, id:UUID, step:NSOrderedSet){
//        super.init()
//
//        self.title = title
//        self.id = id
//        self.step = step
//    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case step
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var step: NSOrderedSet?
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Tutorial", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext) // initializing our struct
        
        let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
        self.title = try container.decodeIfPresent(String.self, forKey: .title) // extracting the data
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) // extracting the data
        let stepArray: [Step]? = try container.decodeIfPresent([Step].self, forKey: .step) // extracting the data
        let step: NSOrderedSet = NSOrderedSet(array: stepArray ?? [])
        self.step = step;
        
        try managedObjectContext.save()
    }
    
    public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(id, forKey: .id)
           try container.encode(title, forKey: .title)
           try container.encode((step ?? []).array as! [Step], forKey: .step)
       }
    
}



