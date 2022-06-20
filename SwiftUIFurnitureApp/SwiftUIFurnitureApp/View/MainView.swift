//
//  MainView.swift
//  SwiftUIFurnitureApp
//
//  Created by ricardo silva on 08/06/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var appViewModel: AppViewModel = .init()
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $appViewModel.currentTab) {
            Home(animation: animation)
                .environmentObject(appViewModel)
                .tag(Tab.home)
                .setUpTab()
            Text("Cart")
                .tag(Tab.cart)
                .setUpTab()
            Text("Favourite")
                .tag(Tab.favourite)
                .setUpTab()
            Text("Profile")
                .tag(Tab.profile)
                .setUpTab()
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(currentTab: $appViewModel.currentTab, animation: animation)
                .offset(y: appViewModel.showDetailView ? 150 : 0)
        }
        .overlay {
            if let furniture = appViewModel.currentActiveItem, appViewModel.showDetailView {
                DetailView(furniture: furniture, animation: animation)
                    .environmentObject(appViewModel)
                    .transition(.offset(x: 1, y: 1))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View {
    
    @ViewBuilder
    func setUpTab() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                Color("BG")
                    .ignoresSafeArea()
            }
    }
}
