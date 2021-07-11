//
//  Project+CoreDataClass.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/6/21.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Project)
public class Project: NSManagedObject {

    func getColor() -> Color {
        do {
            return try Color(NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: projectCardColor!)!)
        } catch {
            print(error)
        }
        return Color.clear
    }
}
