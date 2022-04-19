//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Nick Beresnev on 3/17/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetailView: View {
    @StateObject var store: CharacterDetailStore

    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            switch store.state {
            case .initial, .loading:
                ProgressView()
            case .failed:
                Text("😢 Something went wrong")
            case .finished:
                content
            }
        }
        .navigationTitle(store.character.name)
        .onFirstAppear(perform: load)
    }
}

private extension CharacterDetailView {
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Info")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
            
            HStack(alignment: .top) {
                VStack(alignment: .horizontalInfoAlignment, spacing: 8) {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "creditcard")
                        
                        Text(store.character.name)
                            .alignmentGuide(.horizontalInfoAlignment, computeValue: { $0[.leading]} )
                    }
                    
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "person.fill.questionmark")
                        
                        Text(store.character.species)
                            .alignmentGuide(.horizontalInfoAlignment, computeValue: { $0[.leading]} )
                    }
                    
                    if !store.character.type.isEmpty {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "person.fill.viewfinder")
                            
                            Text(store.character.type)
                                .alignmentGuide(.horizontalInfoAlignment, computeValue: { $0[.leading]} )
                        }
                    }
                    
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "person.and.arrow.left.and.arrow.right")
                        
                        Text(store.character.gender)
                            .alignmentGuide(.horizontalInfoAlignment, computeValue: { $0[.leading]} )
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "globe")
                        
                        Text(store.character.origin.name)
                    }
                    
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "eyes")
                        
                        Text(store.character.location.name)
                    }
                }
            }
        }
            .font(.appItemDescription)
    }
    
    var episodesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Episodes")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
            
            LazyVStack(spacing: 8) {
                ForEach(store.episodes) { episode in
                    HStack {
                        Text(episode.name)
                        
                        Spacer()
                        
                        Text(episode.code)
                    }
                    .font(.appItemDescription)
                    .padding()
                    .background(Color.appBackgroundItem)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }

    var content: some View {
        ScrollView {
            VStack(spacing: 16) {
                WebImage(url: store.character.imageUrl)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                infoSection
                
                episodesSection
            }
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - Actions
private extension CharacterDetailView {
    func load() {
        Task {
            await store.load()
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(store: .init(character: .mock))
    }
}
