//
//  ViewModel.swift
//  DataStoreage_StackOverflow_TEST
//
//  Created by MadG007_MBP on 07.04.22.
//
import Foundation
import CoreData
import Combine

class ViewModel: ObservableObject {
    @Published var dataStore: [DataStore] = []
    
    var storageprovider: StorageProtocol // for DependencyInjection
    
    private var cancellable = Set<AnyCancellable>()
    
    init(storageprovider: StorageProtocol) {
        self.storageprovider = storageprovider // DependencyInjection
        
        // Subscription to the dataStorePublisher
        storageprovider.dataStorePublisher.sink(receiveValue: { dataStore in
            self.dataStore = dataStore
        }).store(in: &cancellable)
    }
}

// Interface of this ViewModel to the StorageProvider
extension ViewModel {
    // save one new DataSet
    func saveData(datum: String) {
        storageprovider.saveData(named: datum)
    }
    // deletes all DataSets
    func deleteAllData() {
        storageprovider.deleteAllData()
    }
    // deletes on selected DataSet
    func deleteDatum(indexSet: IndexSet) {
        storageprovider.deleteOneDatum(offsets: indexSet)
    }
}


