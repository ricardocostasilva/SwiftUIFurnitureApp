//
//  CustomTabBar.swift
//  SwiftUICurvedTabBar
//
//  Created by ricardo silva on 07/06/2022.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var currentTab: Tab
    @State var currentXValue : CGFloat = 0
    
    var animation: Namespace.ID
     
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                TabButton(tab: tab)
                    .overlay {
                        Text(tab.rawValue)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("Black"))
                            .offset(y: currentTab == tab ? 15 : 100)
                    }
            }
        }
        .padding(.top)
        .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 10)
        .background{
            Color.white
                .shadow(color: Color("Black").opacity(0.08),radius: 5, x: 5, y: -5)
                .clipShape(BottomCurve(currentXValue: currentXValue))
                .ignoresSafeArea(.container,edges: .bottom)
        }
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        
        GeometryReader { proxy in
            Button {
                withAnimation(.easeInOut) {
                    currentTab = tab
                    currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                Image(tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.8))
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack {
                            if currentTab == tab {
                                Circle()
                                    .fill(Color("Orange"))
                                    .shadow(color: Color("Black").opacity(0.1),radius: 8, x: 5, y: 5)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -50 : 0)
            }
            .onAppear{
                if tab == Tab.allCases.first && currentXValue == 0 {
                    currentXValue = proxy.frame(in: .global).midX
                }
            }
        }
        .frame(height: 30)
    }
}


enum Tab: String, CaseIterable {
    case home = "Home"
    case cart = "Cart"
    case favourite = "Star"
    case profile = "Profile"
}

extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
