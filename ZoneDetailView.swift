//
//  File.swift
//  Batuque
//
//  Created by Francisco Losada on 16/01/26.
//

import Foundation
import SwiftUI

struct ZoneDetailView: View {
    @EnvironmentObject var mapModel: MapViewModel
    
    var body: some View {
        Text("Zone detail view")
            .navigationTitle(mapModel.selectedZone?.id ?? "No State")
            .navigationBarTitleDisplayMode(.large)
    }
}
