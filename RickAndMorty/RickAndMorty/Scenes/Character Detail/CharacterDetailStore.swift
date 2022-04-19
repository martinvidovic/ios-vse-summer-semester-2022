//
//  CharacterDetailStore.swift
//  RickAndMorty
//
//  Created by Martin Vidovic on 17.04.2022.
//

import Foundation

@MainActor final class CharacterDetailStore: ObservableObject {
    enum State {
        case initial
        case loading
        case finished
        case failed
    }
    
    @Published var state: State = .initial
    @Published var character: Character
    @Published var episodes: [Episode] = .init()
    
    init(character: Character) {
        self.character = character
    }
}

// MARK: - Actions
extension CharacterDetailStore {
    func load() async {
        state = .loading
        
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            await MainActor.run {
                self.episodes = Episode.mockList
                self.state = .finished
            }
        } catch {
            self.state = .failed
        }
    }
}
