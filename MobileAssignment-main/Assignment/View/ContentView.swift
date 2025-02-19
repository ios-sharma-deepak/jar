//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var searchText: String = ""
    
    var searchResults: [DeviceData]? {
            if searchText.isEmpty {
                return viewModel.data
            } else {
                return viewModel.data?.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
    
    
    @State private var path: [DeviceData] = [] // Navigation path

    var body: some View {
        NavigationStack(path: $path) {
            
            Group {
                if let computers = searchResults, !computers.isEmpty {
                    
                    DevicesList(devices: computers) { selectedComputer in
                        viewModel.navigateToDetail(navigateDetail: selectedComputer)
                    }
                    .searchable(text: $searchText)
                   
                } else {
                    ProgressView("Loading...")
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                if let navigate = viewModel.navigateDetail{
                    path.append(navigate)
                }
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                viewModel.fetchAPI()
            }
        }
    }
}
