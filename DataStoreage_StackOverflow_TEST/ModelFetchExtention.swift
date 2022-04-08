//
//  ModelFetchExtention.swift
//  DataStoreage_StackOverflow_TEST
//
//  Created by MadG007_MBP on 07.04.22.
//

import Foundation
import CoreData

extension DataStore {
    static var ascendingIdx: NSFetchRequest<DataStore> = {
        let request: NSFetchRequest<DataStore> = DataStore.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DataStore.idx, ascending: true)]
        return request
    }()
}

extension DataStore {
    static var descendingIdx: NSFetchRequest<DataStore> = {
        let request: NSFetchRequest<DataStore> = DataStore.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DataStore.idx, ascending: false)]
        return request
    }()
}
