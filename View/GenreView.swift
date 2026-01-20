//
//  SwiftUIView.swift
//  Ritmo
//
//  Created by Francisco Losada on 20/01/26.
//

import SwiftUI

struct GenreView: View {
    var genre: String
    var image: String
    var text: String
    var body: some View {
        NavigationStack {
            
            VStack {
                if #available(iOS 17.0, *) {
                    HStack {
                        Text(genre)
                            .textColor()
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * 0.8
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    Text(text)
                        .textColor()
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                }
                else { }
            }
        }
    }
}

#Preview {
    GenreView(genre: "Axé", image: "axe", text: "Axé, or axé music, is a musical genre that emerged in the state of Bahia in the 1980s during the popular celebrations of Salvador's Carnival, mixing samba-reggae,[1] frevo, samba duro,[1] samba afro,[2] ijexá[3] and other Candomblé rhythms,[4] pop rock,[5][6] as well as other Afro-Brazilian and Afro-Latin rhythms.")
}
