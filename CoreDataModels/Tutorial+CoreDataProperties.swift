//
//  Tutorial+CoreDataProperties.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//
//

import Foundation
import CoreData


extension Tutorial {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tutorial> {
        return NSFetchRequest<Tutorial>(entityName: "Tutorial")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var step: NSOrderedSet?
    //@NSManaged public var stepCount: Int16
    
    private enum CodingKeys: String, CodingKey { case id, title, step }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        //try container.encode(step, forKey: .step)
    }
    
    var unwrappedStep: NSOrderedSet{
        step ?? []
    }
    
    func getPositionsConflict(coordinates:String)->Bool{
        var positionCoords:[String] = [""]
    for step in self.unwrappedStep{
        positionCoords.append("\((step as! Step).wrappedPos1Column)\((step as! Step).wrappedPos1Row)")
        }
        print(positionCoords)
        if (positionCoords.contains(coordinates)){
            return true
        }
            return false
    }

}

// MARK: Generated accessors for step
extension Tutorial {

    @objc(addStepObject:)
    @NSManaged public func addToStep(_ value: Step)

    @objc(removeStepObject:)
    @NSManaged public func removeFromStep(_ value: Step)

    @objc(addStep:)
    @NSManaged public func addToStep(_ values: NSSet)

    @objc(removeStep:)
    @NSManaged public func removeFromStep(_ values: NSSet)

}
