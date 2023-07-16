//
//  LandmarkList.swift
//  
//
//  Created by Berny E on 2023-07-09.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    @State private var searchText = ""
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            ((!showFavoritesOnly || landmark.isFavorite) &&
             (searchText == "" || landmark.name.contains(searchText))
            )
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                .toggleStyle(.switch)
                
                Text("Searching for \(searchText)")
                
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
        .navigationTitle("Landmarks")
        .searchable(text: $searchText, placement: .toolbar, prompt: "Landmark Name"){
            ForEach(searchResults, id: \.self) { result in
                Text("Looking for \(result)?").searchCompletion(result)
            }
        }
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return filteredLandmarks.map { $0.name }
        } else {
            return filteredLandmarks.map{$0.name}.filter{ $0.contains(searchText)}
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        modelData.landmarks.remove(atOffsets: offsets)
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}
