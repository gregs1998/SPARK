//
//  Step+CoreDataClass.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Step)
public class Step: NSManagedObject, Encodable {

    enum CodingKeys: String, CodingKey {
        case descrip
        case pos1Row
        case pos2Row
        case pos1Column
        case pos2Column
        case resistance
        case voltage
        case componentType
        case id
        case tutorial
        case stepNum
        
    }
    
    @NSManaged public var descrip: String?
    @NSManaged public var pos1Row: String?
    @NSManaged public var pos2Row: String?
    @NSManaged public var pos1Column: String?
    @NSManaged public var pos2Column: String?
    @NSManaged public var resistance: String?
    @NSManaged public var voltage: String?
    @NSManaged public var componentType: String?
    @NSManaged public var id: UUID?
    @NSManaged public var tutorial: Tutorial?
    @NSManaged public var stepNum: Int16
    
//    required convenience public init(from decoder: Decoder) throws {
//        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("Error: NSManagedObjectContext not available") }
//        let entity = NSEntityDescription.entity(forEntityName: "Step", in: context)!
//
//        self.init(entity: entity, insertInto: context) // initializing our struct
//
//        let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
//        self.id = try container.decode(UUID?.self, forKey: .id) // extracting the data
//        self.descrip = try container.decode(String?.self, forKey: .descrip) // extracting the data
//        self.pos1Row = try container.decode(String?.self, forKey: .pos1Row) // extracting the data
//        self.pos2Row = try container.decode(String?.self, forKey: .pos2Row) // extracting the data
//        self.pos1Column = try container.decode(String?.self, forKey: .pos1Column) // extracting the data
//        self.pos2Column = try container.decode(String?.self, forKey: .pos2Column) // extracting the data
//        self.resistance = try container.decode(String?.self, forKey: .resistance) // extracting the data
//        self.voltage = try container.decode(String?.self, forKey: .voltage) // extracting the data
//        self.componentType = try container.decode(String?.self, forKey: .componentType) // extracting the data
//        self.stepNum = try container.decode(Int16.self, forKey: .stepNum) // extracting the data
//    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(wrappedDescrip, forKey: .descrip)
        try container.encode(pos1Row, forKey: .pos1Row)
        try container.encode(pos2Row, forKey: .pos2Row)
        try container.encode(pos1Column, forKey: .pos1Column)
        try container.encode(pos2Column, forKey: .pos2Column)
        try container.encode(resistance, forKey: .resistance)
        try container.encode(voltage, forKey: .voltage)
        try container.encode(componentType, forKey: .componentType)
        try container.encode(stepNum, forKey: .stepNum)
    }
    
}

class StepController{
    
//    func parse(_ jsonData: Data) -> Bool {
//        do {
//            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
//                fatalError("Failed to retrieve context")
//            }
//
//            // Parse JSON data
//            //let managedObjectContext = persistentContainer.viewContext
//            let decoder = JSONDecoder()
//            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
//            _ = try decoder.decode(Step.self, from: jsonData)
//            try managedObjectContext.save()
//
//            return true
//        } catch let error {
//            print(error)
//            return false
//        }
//    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}
