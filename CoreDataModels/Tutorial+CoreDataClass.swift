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

public func jsonToTutorial(data: Data, moc:NSManagedObjectContext) -> Tutorial{
    var stepsJSON: [Step] = []
    let newTutorial: Tutorial = Tutorial(context: moc)
    do{
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
            if let id = json["id"] as? UUID{
                newTutorial.id = id
            }
            if let title = json["title"] as? String{
                newTutorial.title = title
            }
            let steps = json["step"] as! [[String:Any]]
            for step in steps{
                let newStep = Step(context: moc)
                if let pos2Row = step["pos2Row"] as? String{
                    newStep.pos2Row = pos2Row
                }
                if let pos1Row = step["pos1Row"] as? String{
                    newStep.pos1Row = pos1Row
                }
                if let descrip = step["descrip"] as? String{
                    newStep.descrip = descrip
                }
                if let componentType = step["componentType"] as? String{
                    newStep.componentType = componentType
                }
                if let pos1Column = step["pos1Column"] as? String{
                    newStep.pos1Column = pos1Column
                }
                if let pos2Column = step["pos2Column"] as? String{
                    newStep.pos2Column = pos2Column
                }
                if let resistance = step["resistance"] as? String{
                    newStep.resistance = resistance
                }
                if let voltage = step["voltage"] as? String{
                    newStep.voltage = voltage
                }
                if let id = step["id"] as? UUID{
                    newStep.id = id
                }
                if let stepNum = step["stepNum"] as? Int16{
                    newStep.stepNum = stepNum
                }
                newStep.tutorial = newTutorial
                stepsJSON.append(newStep)
            }
            newTutorial.step = NSOrderedSet(array: stepsJSON)
        }
    } catch {
        print("Error fetching step from CoreData")
    }
    return newTutorial
}


@objc(Tutorial)
public class Tutorial: NSManagedObject, Encodable{
    
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
    
//    required convenience public init(from decoder: Decoder) throws {
//        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("Error: NSManagedObjectContext not available") }
//        let entity = NSEntityDescription.entity(forEntityName: "Tutorial", in: context)!
//
//        self.init(entity: entity, insertInto: context)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
//        self.title = try container.decodeIfPresent(String.self, forKey: .title) // extracting the data
//        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) // extracting the data
//        let stepArray: [Step]? = try container.decodeIfPresent([Step].self, forKey: .step) // extracting the data
//        let step: NSOrderedSet = NSOrderedSet(array: stepArray ?? [])
//        self.step = step;
//
//        try context.save()
//    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode((step ?? []).array as! [Step], forKey: .step)
    }
}



