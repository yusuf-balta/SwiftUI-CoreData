//
//  CoreDataManager.swift
//  coredataexample
//
//  Created by Yusuf Balta on 7.08.2022.
//

import Foundation
import CoreData

class CoreDataManager  {
    
    let persistentContainer : NSPersistentContainer
    static let shared : CoreDataManager = CoreDataManager()
    
    private init(){
        
        persistentContainer = NSPersistentContainer(name: "SimpleTodoModel")
        persistentContainer.loadPersistentStores { descr , error in
            if let error = error {
                fatalError("Unable to initlize core data \(error)")
            }
            
        }
    }
}
