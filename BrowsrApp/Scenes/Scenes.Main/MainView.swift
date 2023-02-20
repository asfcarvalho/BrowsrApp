//
//  MainViewView.swift
//  BrowsrApp
//
//  Created by Anderson F Carvalho on 20/02/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Common
import BaseUI
import Components
import BrowsrLib

struct MainView: View {
    
    @ObservedObject var input: MainViewModel
    public var output = MyObservableObject<ViewModel.Main.ViewOutput.Action>()
    
    private var token = CancelBag()
    @State private var searchText = ""
    
    init(input: MainViewModel) {
        self.input = input
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if let organizations = input.organizations {
                    ScrollView {
                        ForEach(organizations, id: \.self) { item in
                            HStack {
                                imageView(item.avatarUrl)
                                VStack(alignment: .leading) {
                                    HStack(spacing: 8) {
                                        Text("Login:")
                                        Text(item.login)
                                    }
                                    HStack(spacing: 8) {
                                        Text("NodeId:")
                                        Text(item.nodeId)
                                    }
                                }
                                Spacer()
                                favoriteView(item.isFavorite, item.id)
                            }.padding(.horizontal)
                                .frame(width: UIScreen.screenWidth, alignment: .leading)
                        }
                    }
                } else {
                    Text("No Organization found")
                }
            }.onChange(of: searchText) { newValue in
                output.value.send(.searching(newValue))
            }
        }.searchable(text: $searchText, prompt: "Serach for Login")
    }
    
    private func imageView(_ url: String) -> some View {
        AsyncImage(
            url: URL(string: url)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                } else if let error = phase.error {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay {
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.gray)
                        }
                    let _ = debugPrint(error)
                } else {
                    ProgressView()
                }
            }
    }
    
    private func favoriteView(_ isFavorite: Bool, _ id: Int) -> some View {
        Button {
            output.value.send(.favoriteTapped(isFavorite, id))
        } label: {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .resizable()
                .foregroundColor(Color.yellow)
                .frame(width: 30, height: 30)
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(input: .init())
    }
}
