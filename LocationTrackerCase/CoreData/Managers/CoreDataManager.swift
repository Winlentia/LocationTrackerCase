//
//  CoreDataManager.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "LocationModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("loadPersistentStores error \(error)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Contextsave error \(nserror)")
            }
        }
    }
    
    func getAllPLocations() -> [PLocation] {
        var items: [PLocation] = []
        do {
            items = try context.fetch(PLocation.fetchRequest())
        } catch {
            print(error)
        }
        return items
    }
    
    func createPLocation(latitude: Double, longitude: Double) {
        let item = PLocation(context: context)
        item.latitude = latitude
        item.longitude = longitude
        saveContext()
    }

    func deletePLocation(pLocation: PLocation) {
        context.delete(pLocation)
        saveContext()
    }
    
    func deleteAllPlocations() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: PLocation.fetchRequest())
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
