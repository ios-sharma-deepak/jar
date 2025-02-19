//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State var searchText : String = ""
    
    @State private var path: [DeviceData] = [] // Navigation path

    var body: some View {
        NavigationStack(path: $path) {
            
            Group {
                if let computers = viewModel.data, !computers.isEmpty {
                    
                    DevicesList(devices: computers) { selectedComputer in
                        viewModel.navigateToDetail(navigateDetail: selectedComputer)
                    }
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
//                let navigate = viewModel.navigateDetail
//                if (viewModel.navigateDetail != nil) {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        path.append(navigate!)
//                    }
//                }
            }
        }
    }
}
