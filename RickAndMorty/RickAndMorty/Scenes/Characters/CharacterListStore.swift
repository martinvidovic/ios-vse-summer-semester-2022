//
//  CharacterListStore.swift
//  RickAndMorty
//
//  Created by Martin Vidovic on 17.04.2022.
//

import Foundation

@MainActor final class CharactersListStore: ObservableObject {
    enum State {
        case initial
        case loading
        case finished
        case failed
    }
    
    @Published var state: State = .initial
    @Published var characters: [Character] = .init()
}

// MARK: - Actions
extension CharactersListStore {
    func load() async {
        state = .loading
        
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            await MainActor.run {
                self.characters = Character.mockList
                self.state = .finished
            }
        } catch {
            self.state = .failed
        }
    }
}
