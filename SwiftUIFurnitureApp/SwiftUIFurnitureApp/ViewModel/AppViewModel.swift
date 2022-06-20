//
//  AppViewModel.swift
//  SwiftUIFurnitureApp
//
//  Created by ricardo silva on 07/06/2022.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var currentTab: Tab = .home
    
    @Published var currentMenu: HomeMenu = .all
    
    @Published var showDetailView: Bool = false
    @Published var currentActiveItem: Furniture?
}
