//
//  File.swift
//  Ritmo
//
//  Created by Francisco Losada on 20/01/26.
//

import Foundation

@available(iOS 17.0, *)
struct GenreViewModel {
    func getStateGenre(state: String) -> [String] {
        switch state {
        case "RJ":
            return ["Samba-Enredo", "Partido-Alto"]
        case "BA":
            return ["Baião", /*"Ijexá",*/ "Axé"]
        case "PE":
            return ["Maracatu", "Frevo", ]
        default:
            return []
        }
    }
    
    func getLabel(genre: String) -> String {
        switch genre {
        case "Axé":
            return "burst.fill"
        case "Frevo":
            return "umbrella.fill"
        case "Samba-Enredo":
            return "party.popper.fill"
        case "Partido-Alto":
           return "hat.widebrim.fill"
        case "Maracatu":
            return "laser.burst"
        case "Baião":
            return "sun.min.fill"
        default:
            return "heart.fill"
        }
    }
    
    @MainActor func getGenreInfo(genre: String) -> GenreView {
        switch genre {
        case "Axé":
            GenreView(genre: "Axé", image: "axe", text: "Axé, or axé music, is a musical genre that emerged in the state of Bahia in the 1980s during the popular celebrations of Salvador's Carnival, mixing samba-reggae, frevo, samba duro, samba afro, ijexá and other Candomblé rhythms,pop rock,as well as other Afro-Brazilian and Afro-Latin rhythms.", audio: "axe")
        case "Frevo":
            GenreView(genre: "Frevo", image: "frevo", text: "Originating in Pernambuco at the end of the 19th century, frevo is characterized by its extremely fast rhythm. Frequently performed during Carnival, conflicts between frevo groups were common, with capoeira practitioners leading their groups to intimidate rival groups and protect their own. Frevo is a creation of composers of light music, made for Carnival to provide more animation to the festivities. Over time, frevo has acquired its own characteristics.", audio: "frevo")
        case "Samba-Enredo":
            GenreView(genre: "Samba-Enredo", image: "sambaEnredo", text: "Samba-enredo, also called samba de enredo, is a subgenre of samba. Samba-enredos are composed specifically for carnival parades of samba schools. The samba-enredo consists of melody and lyrics created from the theme chosen each year for the parade of each school. The lyrics contain a plot, that is, a narrative - preferably with a beginning, middle and end - from which the entire script of the show is developed.", audio: "sambaEnredo")
        case "Partido-Alto":
            GenreView(genre: "Partido-Alto", image: "partidoAlto", text: "Samba de partido-alto, partido-alto or simply partido, is a style of samba that emerged in the early 20th century as part of the modernization of urban samba in Rio de Janeiro. It has its origins in African umbigadas and is the form of samba that most closely resembles the origins of Angolan batuque, from Congo and nearby regions. Despite being one of the most traditional subgenres of samba, there is no consensus among practitioners and scholars, whether more or less erudite, to define what this derivation of samba is, largely due to the changes it has undergone from its origin to the present day.", audio: "partidoAlto")
        case "Maracatu":
            GenreView(genre: "Maracatu", image: "maracatu", text: "Maracatu is a musical rhythm, dance, and ritual of religious syncretism originating in the Brazilian state of Pernambuco. There are two types, according to the baque or beat: Maracatu Nação (Baque Virado) and Maracatu Rural (Baque Solto). The first, quite common in the metropolitan area of ​​Recife, is the oldest Afro-Brazilian rhythm; and the second is characteristic of the city of Nazaré da Mata (Zona da Mata Norte, Pernambuco). It was registered as a form of expression and Cultural Heritage of Brazil – approved by the National Institute of Historic and Artistic Heritage (IPHAN) – alongside manifestations such as marabaixo (Amapá), carimbó (Pará), tambor de crioula (Maranhão), and the kusiwa art of the Waiãpi indigenous people (Amapá).", audio: "maracatu")
        case "Baião":
            GenreView(genre: "Baião", image: "baiao", text: "Baião is a genre of popular music and dance from the Northeast region of Brazil, derived from a type of lundu, called baiano, from which its name is a corruption. Baião makes extensive use of the following musical instruments: viola caipira, triangle, recorder, and accordion (also called sanfona). The rabeca is considered the characteristic instrument of Baião, given its sound reminiscent of the accordion, which in turn would be the most identified instrument when the rhythm became known nationally and internationally. The sounds of these instruments are interspersed with singing. The theme of baião is the daily life of the sertanejos (inhabitants of the sertão region) and the difficulties of their lives, as in the song Asa Branca, which speaks of the suffering of the sertanejos due to the northeastern drought.", audio: "baiao")
        default:
            GenreView(genre: "Não tem info ainda", image: "", text: "", audio: "")
        }
    }
}



