//
//  MainViewControllerViewController.swift
//  BrowsrApp
//
//  Created by Anderson F Carvalho on 20/02/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import BrowsrLib

class MainViewController: UIHostingController<MainView> {
    
    private var token = CancelBag()
    private var viewModel: MainViewModel?
    
    override init(rootView: MainView) {
        super.init(rootView: rootView)
        
        viewModel = rootView.input
        configureComunication()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.send(action: .onAppear)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureComunication() {
        rootView.output.value.sink { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .dismiss:
                self.viewModel?.send(action: .dismiss)
            case .favoriteTapped(let isFavorite, let id):
                self.viewModel?.send(action: .favoriteTapped(isFavorite, id))
            case .searching(let text):
                self.viewModel?.send(action: .searching(text))
            }
        }.store(in: token)
    }
}
