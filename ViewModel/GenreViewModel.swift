//
//  File.swift
//  Ritmo
//
//  Created by Francisco Losada on 20/01/26.
//

import Foundation

struct GenreViewModel {
    func getStateGenre(state: String) -> [String] {
        switch state {
        case "RJ":
            return ["Samba-Enredo", "Partido-Alto"]
        case "BA":
            return ["Baião", "Ijexá", "Axé"]
        case "PE":
            return ["Maracatu", "Frevo", ]
        default:
            return []
        }
    }
    
    func getGenreInfo(genre: String) -> GenreView {
        switch genre {
        case "Axé":
            GenreView(genre: "Axé", image: "axe", text: "Axé, or axé music, is a musical genre that emerged in the state of Bahia in the 1980s during the popular celebrations of Salvador's Carnival, mixing samba-reggae, frevo, samba duro, samba afro, ijexá and other Candomblé rhythms,pop rock,as well as other Afro-Brazilian and Afro-Latin rhythms.")
        case "Frevo":
            GenreView(genre: "Frevo", image: "frevo", text: "Originating in Pernambuco at the end of the 19th century, frevo is characterized by its extremely fast rhythm. Frequently performed during Carnival, conflicts between frevo groups were common, with capoeira practitioners leading their groups to intimidate rival groups and protect their own. Frevo is a creation of composers of light music, made for Carnival to provide more animation to the festivities. Over time, frevo has acquired its own characteristics.")
        case "Samba-Enredo":
            GenreView(genre: "Samba-Enredo", image: "sambaEnredo", text: "Samba-enredo, also called samba de enredo, is a subgenre of samba. Samba-enredos are composed specifically for carnival parades of samba schools. The samba-enredo consists of melody and lyrics created from the theme chosen each year for the parade of each school. The lyrics contain a plot, that is, a narrative - preferably with a beginning, middle and end - from which the entire script of the show is developed.")
        default:
            GenreView(genre: "Não tem info ainda", image: "", text: "")
        }
    }
}



