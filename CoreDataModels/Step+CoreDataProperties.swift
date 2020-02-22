//
//  Step+CoreDataProperties.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
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
    
    var wrappedDescrip: String{
        descrip ?? "Unknown Description"
    }
    
    var wrappedPos1Row: String{
        pos1Row ?? "0"
    }
    
    var wrappedPos1Column: String{
        pos1Column ?? "A"
    }
    
    var wrappedPos2Row: String{
        pos2Row ?? "0"
    }
    
    var wrappedPos2Column: String{
        pos2Column ?? "A"
    }
    
    var wrappedVoltage: String{
        voltage ?? "0"
    }
    
    var wrappedResistance: String{
        resistance ?? "0"
    }
    
    var wrappedComponentType: String{
        componentType ?? "Resistor"
    }
    
    var wrappedTutorial: Tutorial{
        tutorial ?? Tutorial()
    }
}
