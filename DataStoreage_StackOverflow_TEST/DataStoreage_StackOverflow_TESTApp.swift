//
//  DataStoreage_StackOverflow_TESTApp.swift
//  DataStoreage_StackOverflow_TEST
//
//  Created by MadG007_MBP on 07.04.22.
//

import SwiftUI

@main
struct DataStoreage_StackOverflow_TESTApp: App {
    // for DependencyInjection / MockStorageProviders e.g. have to conform to the StorageProtocol Protocol
    let storageProvider: StorageProtocol = StorageProvider()
    var body: some Scene {
        WindowGroup {
            ContentView(storageprovider: storageProvider) // DependencyInjection
        }
    }
}
