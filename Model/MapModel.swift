//
//  SwiftUIView.swift
//  Batuque
//
//  Created by Francisco Losada on 16/01/26.
//

import SwiftUI
import MapKit

struct Zone: Identifiable, Decodable {
    var coordinates: [CLLocationCoordinate2D]
    
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id, coordinates
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let rawCoordinates = try container.decode([[Double]].self, forKey: .coordinates)
        var coordinates = [CLLocationCoordinate2D]()
        
        for rawVertex in rawCoordinates {
            coordinates.append(.init(latitude: rawVertex[1], longitude: rawVertex[0]))
        }
        self.coordinates = coordinates
    }
}

enum States {
    case RJ, BA, PE
}


