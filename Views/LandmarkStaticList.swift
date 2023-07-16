//
//  LandmarkStaticList.swift
//  
//
//  Created by Berny E on 2023-07-16.
//

import SwiftUI

struct LandmarkStaticItem: View {
    let name: String
    
    var body: some View {
        Text("Landmark: \(name)")
    }
}

struct LandmarkStaticList: View {
    var body: some View {
        List {
            LandmarkStaticItem(name: "Turtle Rock")
            LandmarkStaticItem(name: "Silver Salmon Creek")
            LandmarkStaticItem(name: "Chilkoot Trail")
        }
    }
}

struct LandmarkStaticList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkStaticList()
    }
}
