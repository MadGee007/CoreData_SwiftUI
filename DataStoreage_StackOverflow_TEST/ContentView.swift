//
//  ContentView.swift
//  DataStoreage_StackOverflow_TEST
//
//  Created by MadG007_MBP on 07.04.22.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel: ViewModel
    @State private var count = 0

    // DependencyInjection / initializing of the wrappedValue with DependencyInjection using "_"
    init(storageprovider: StorageProtocol) {
        _viewModel = StateObject(wrappedValue: ViewModel(storageprovider: storageprovider))
    }
    
    var body: some View {
        VStack {
            VStack {
                List {
                    ForEach(viewModel.dataStore) { data in
                        HStack {
                            Text(data.nameData ?? "No data from ViewModel")
                        }
                    }
                    .onDelete(perform: viewModel.deleteDatum)
                }
                HStack {
                    Button("EnterData") {
                        count += 1
                        viewModel.saveData(datum: "TestData: \(count)" )
                    } .padding()
                    Button("DeleteAll") {
                        count = 0
                        viewModel.deleteAllData()
                    } .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    // Dependency Injection, StoregeProvider has to confirme to the StorageProtocol
    static let storageProvider: StorageProtocol = StorageProvider()
    
    static var previews: some View {
        ContentView(storageprovider: storageProvider)
    }
}
