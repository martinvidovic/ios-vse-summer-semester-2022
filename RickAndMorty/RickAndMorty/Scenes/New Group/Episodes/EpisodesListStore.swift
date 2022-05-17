//
//  EpisodesListStore.swift
//  RickAndMorty
//
//  Created by Martin Vidovic on 17.04.2022.
//

import Foundation

@MainActor final class EpisodesListStore: ObservableObject {
    enum State {
        case initial
        case loading
        case finished
        case failed
    }

    @Published var state: State = .initial
    @Published var episodes: [Episode] = .init()
}

// MARK: - Actions
extension EpisodesListStore {
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
