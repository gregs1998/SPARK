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
    
//    func JSONstuff(){
//        let data: Data = "{\n\t\"somekey\": 42.0,\n\t\"anotherkey\": {\n\t\t\"somenestedkeys\": true\n\t}\n}".data(using: .utf8) ?? Data()
//        let json = try? JSONSerialization.jsonObject(with: data, options: [])
//        //print(data)
//        let bob = json as? [Any]
//        //print(json!)
//        print(bob ?? "Failed")
//    }

    //@NSManaged public var descrip: String?
    //@NSManaged public var pos1Row: String?
    //@NSManaged public var pos2Row: String?
    //@NSManaged public var pos1Column: String?
    //@NSManaged public var pos2Column: String?
    //@NSManaged public var resistance: String?
    //@NSManaged public var voltage: String?
    //@NSManaged public var componentType: String?
    //@NSManaged public var id: UUID?
    //@NSManaged public var tutorial: Tutorial?
    //@NSManaged public var stepNum: Int16
    
    //private enum CodingKeys: String, CodingKey { case descrip, pos1Row, pos2Row, pos1Column, pos2Column, resistance, voltage, componentType, id, tutorial, stepNum }
    
    /*public func encode(to encoder: Encoder) throws {
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
        //try container.encode(tutorial, forKey: .tutorial)
        try container.encode(stepNum, forKey: .stepNum)
    }*/
    //@interface NSJSONSerialization : NSObject
    
    
    var wrappedDescrip: String{
        descrip ?? "Unknown Description"
    }
    
    var wrappedPos1Row: String{
        pos1Row ?? "0"
    }
    
    var wrappedPos1RowDouble: Double{
        Double(wrappedPos1Row) ?? 0.0
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
