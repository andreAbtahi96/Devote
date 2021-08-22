//
//  Persistence.swift
//  Devote
//
//  Created by Andre Abtahi on 8/18/21.
//

import CoreData

struct PersistenceController {
    
    //  MARK: - 1. PERSISTANT CONTROLLER: Instance of this set's up model, context, and cordinator
    static let shared = PersistenceController()

    //  MARK: - 2. PERSISTANT CONTAINER: prefered way to init core data stack and load model.
    let container: NSPersistentContainer

    //  MARK: - 3. INITIALIZATION (load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Devote")
        
        if inMemory { // allows us to access non disk storage
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        // loading the store ( persistent or temporary)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    //  MARK: - 4. PREVIEW
    static var preview: PersistenceController = {
        
        // switch in memory store
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        //setting up 10 dummy data items
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample task No\(i)"
            newItem.completion = false
            newItem.id = UUID()
        }
        
        // save data in memory storage
        do {
            try viewContext.save()
        } catch {

            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
