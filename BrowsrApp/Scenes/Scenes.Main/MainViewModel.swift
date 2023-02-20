//
//  MainViewModelViewModel.swift
//  BrowsrApp
//
//  Created by Anderson F Carvalho on 20/02/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import BaseUI
import BrowsrLib
import LocalDatabase

class MainViewModel: ObservableObject {
    @Published var organizations: [Model.Organizatiion]?
    
    private var organizationsBase: [Model.Organizatiion] = []
    private var organizationsFavorite: [Int] = []
    
    var router: MainRouter?
    private var organizationDataSource: OrganizationFetchProtocol!
    private var favoriteStorage: OrganizationFavoriteRepositoryProtocol!
    
    init(organizations: [Model.Organizatiion] = [],
         organizationDataSource: OrganizationFetchProtocol = OrganizationFetch(),
         favoriteStorage: OrganizationFavoriteRepositoryProtocol = OrganizationFavoriteStorageRepository()) {
        self.organizations = organizations
        self.organizationDataSource = organizationDataSource
        self.favoriteStorage = favoriteStorage
    }
}

extension MainViewModel {
    
    public func send(action: ViewModel.Main.ViewInput.Action) {
        switch action {
        case .dismiss:
            router?.perform(action: .dismiss)
        case .onAppear:
            fetchFavorites()
            fetchOrganization()
        case .favoriteTapped(let isFavorte, let id):
            setIsFavorite(isFavorte, id)
        case .searching(let text):
            searching(text)
        }
    }
    
    private func fetchOrganization() {
        organizationDataSource.organizationFetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.setFavorites(success)
            case .failure(let failure):
                debugPrint(failure)
            }
        }
    }
    
    private func fetchFavorites() {
        favoriteStorage.getAllFavorite { result in
            switch result {
            case .success(let favorites):
                self.organizationsFavorite = favorites
            case .failure(let failure):
                debugPrint(failure)
            }
        }
    }
    
    private func setFavorites(_ organizations: [Model.Organizatiion]) {
        var organizations = organizations
        organizationsFavorite.forEach({ item in
            if let index = organizations.firstIndex(where: { $0.id == item }) {
                organizations[index].isFavorite = true
            }
        })
        
        self.organizationsBase = organizations
        self.searching("")
    }
    
    private func setIsFavorite(_ status: Bool, _ id: Int) {
        if status {
            removeFavorite(id, status)
        } else {
            addFavorite(id, status)
        }
    }
    
    private func addFavorite(_ id: Int, _ status: Bool) {
        favoriteStorage.saveFavorite(id) { result in
            switch result {
            case .success:
                setOrganizationStatus(id, status)
            case .failure(let failure):
                debugPrint(failure)
            }
        }
    }
    
    private func removeFavorite(_ id: Int, _ status: Bool) {
        favoriteStorage.removeFavorite(id) { result in
            switch result {
            case .success:
                setOrganizationStatus(id, status)
            case .failure(let failure):
                debugPrint(failure)
            }
        }
    }
    
    private func setOrganizationStatus(_ id: Int, _ status: Bool) {
        if let index = organizations?.firstIndex(where: { $0.id == id }) {
            organizations?[index].isFavorite = !status
        }
    }
    
    private func searching(_ text: String) {
        if text.isEmpty {
            self.organizations = organizationsBase
        } else {
            self.organizations = organizationsBase.filter({ $0.login.lowercased().contains(text.lowercased()) })
        }
    }
}

public extension ViewModel {
    enum Main {
        public enum ViewOutput {
            public enum Action: Hashable {
                case favoriteTapped(_ isFavorite: Bool, _ id: Int)
                case searching(_ text: String)
                case dismiss
            }
        }
        
        public enum ViewInput: Hashable {
            public enum Action: Hashable {
                case dismiss
                case onAppear
                case favoriteTapped(_ isFavorite: Bool, _ id: Int)
                case searching(_ text: String)
            }
        }
    }
}
