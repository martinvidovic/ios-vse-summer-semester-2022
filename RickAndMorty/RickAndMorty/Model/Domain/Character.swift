//
//  Character.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

struct Character {
    let id: Int
    let name: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOrigin
    let location: CharacterLocation
    let imageUrl: URL
    let episodeUrls: [URL]
        
    var episodeIds: [Int] {
        episodeUrls
            .compactMap {
                Int($0.lastPathComponent)
            }
    }
}

// MARK: - Conformances
extension Character: Identifiable {}
extension Character: Equatable {}

// MARK: - Mock
#if DEBUG
extension Character {
    static let mock: Character = .init(
        id: 1,
        name: "Rick Sanchez",
        species: "Human",
        type: "",
        gender: "Male",
        origin: .mock,
        location: .mock,
        imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        episodeUrls: [
            URL(string: "https://rickandmortyapi.com/api/episode/1")!,
            URL(string: "https://rickandmortyapi.com/api/episode/2")!
        ]
    )
}
#endif
