//
//  StorageProvider.swift
//  DataStoreage_StackOverflow_TEST
//
//  Created by MadG007_MBP on 07.04.22.
//

import Foundation
import CoreData
import Combine

// Typ of StorageProvider
enum StoreType {
    case inMemory  // only for UnitTests, not persistent
    case persisted // for the App, persistent
}

// Protocol for StorageProviders / MockStoreageProviders e.g. have to conform to this protocol
protocol StorageProtocol {
    var dataStorePublisher: CurrentValueSubject<[DataStore], Never> { get }
    var sortAscendingIdx: Bool { get set }
    
    func saveData(named nameData: String)
    func deleteOneDatum(offsets: IndexSet)
    func deleteAllData()
}

// StorageProvider Class
class StorageProvider: StorageProtocol {
    
    // DataStores Publisher
    let dataStorePublisher = CurrentValueSubject<[DataStore], Never>([])
    
    // Selection if the sorting regarding Idx shall be ascending or descending
    var sortAscendingIdx = true
    
    private let persistentContainer: NSPersistentContainer
    
    init(storeType: StoreType = .persisted) {

        persistentContainer = NSPersistentContainer(name: "Model")
        
        // Only in used for UnitTests! Will creat a non persistent DataStore
        if storeType == .inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null") // not persistent
        }
        
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error { fatalError("Core Data store failed to load with error: \(error)") }
        })
        
        updateDataStore() // fetches an existing DataStore from a previous session during init()
    }
}

// Internal "private" Methods //
// Fetching/Updating of the DataStore according to the selected fetchrequest
extension StorageProvider {
    private func updateDataStore() {
        do {
            var fetchRequest: NSFetchRequest<DataStore>
            
            // selection of an ascending/decending fetch
            switch sortAscendingIdx {
            case true:
                fetchRequest = DataStore.ascendingIdx // fetches ascending
            case false:
                fetchRequest = DataStore.descendingIdx // fetches descending
            }
            dataStorePublisher.value = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to update DataStore: \(error)")
            return
        }
    }
}

// public methodes for use by the ViewModel
// save methode for a new entered dataset
extension StorageProvider {
    func saveData(named nameData: String) {
        let dataAux = DataStore(context: persistentContainer.viewContext)
        dataAux.nameData = nameData
        dataAux.idx = Int64(dataStorePublisher.value.count) // Aufbau des Indexes
        do {
            try persistentContainer.viewContext.save()
            print("Data saved succesfully after saveData")
            updateDataStore()
            
        } catch {
            print("Failed to save data: \(error)")
        }
    }
}


// delet methode for one dataset
extension StorageProvider {
    func deleteOneDatum(offsets: IndexSet) {
        offsets.map{dataStorePublisher.value[$0]}.forEach(persistentContainer.viewContext.delete)
        do {
            try persistentContainer.viewContext.save()
            print("Data saved succesfully after deleteOneDatum")
            updateDataStore()
            
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
    }
}

// delete methode for the entire dataset
extension StorageProvider {
    func deleteAllData() {
        
        // all datasets will be deleted on by on
        dataStorePublisher.value.forEach(persistentContainer.viewContext.delete)
        
        do {
            try persistentContainer.viewContext.save()
            print("All Data erased succesfully deleteAllData")
            updateDataStore()
            
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
    }
}
