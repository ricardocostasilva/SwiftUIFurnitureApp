//
//  Home.swift
//  SwiftUIFurnitureApp
//
//  Created by ricardo silva on 07/06/2022.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    var animation: Namespace.ID
    var black: Color = Color("Black")
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Best Furniture")
                        .font(.title.bold())
                    Text("Perfect Choice!")
                        .font(.callout)
                }
                .foregroundColor(black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Image("Search")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(black)
                        
                        TextField("Search", text: .constant(""))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    }
                    
                    Button {
                        
                    } label: {
                        Image("Filter")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(black)
                            .frame(width: 25, height: 25)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            }
                    }

                }
                CustomMenu()
                
                ForEach(furnitures) { furniture in
                    CardView(furniture: furniture)
                }
            }
            .padding()
            .padding(.bottom, 100)
        }
    }
    
    @ViewBuilder
    func CardView(furniture: Furniture) -> some View {
        HStack(spacing: 12) {
            Group {
                if appViewModel.currentActiveItem?.id == furniture.id && appViewModel.showDetailView {
                    Image(furniture.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(furniture.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: furniture.id + "IMAGE", in: animation)
                }
            }
            .frame(width: 120)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color("CardBG"))
            }
        
            VStack(alignment: .leading, spacing: 10) {
                
                Group {
                    if appViewModel.currentActiveItem?.id == furniture.id && appViewModel.showDetailView {
                        Text(furniture.title)
                            .fontWeight(.bold)
                            .foregroundColor(black)
                            .opacity(0)
                        Text("by Ricardo")
                            .font(.caption2.bold())
                            .foregroundColor(.gray)
                            .padding(.top, -5)
                            .opacity(0)
                    } else {
                        Text(furniture.title)
                            .fontWeight(.bold)
                            .foregroundColor(black)
                            .matchedGeometryEffect(id: furniture.title + "TITLE", in: animation)
                        Text("by Ricardo")
                            .font(.caption2.bold())
                            .foregroundColor(.gray)
                            .padding(.top, -5)
                            .matchedGeometryEffect(id: furniture.title + "SUBTITLE", in: animation)
                    }
                }
                

                
                Text(furniture.subTitle)
                    .font(.system(size: 14))
                    .foregroundColor(black.opacity(0.8))
                
                HStack {
                    Text(furniture.price)
                        .font(.title3.bold())
                        .foregroundColor(black)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Buy")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background {
                                Capsule()
                                    .fill(Color("Orange"))
                            }
                    }
                    .scaleEffect(0.9)

                }
                .offset(y:10)
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
                .shadow(color: black.opacity(0.08),radius: 5, x: 5, y: 5)
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                appViewModel.showDetailView = true
                appViewModel.currentActiveItem = furniture
            }
        }
        .padding(.bottom, 6)
    }
    
    @ViewBuilder
    func CustomMenu()-> some View {
        HStack(spacing: 0) {
            ForEach(HomeMenu.allCases, id: \.self) { menu in
                Text(menu.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(appViewModel.currentMenu != menu ? black : .white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background {
                        if appViewModel.currentMenu == menu {
                            Capsule()
                                .fill(black)
                                .shadow(color: black.opacity(0.1),radius: 5, x:5, y:5)
                                .matchedGeometryEffect(id: "Menu", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            appViewModel.currentMenu = menu
                        }
                    }
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum HomeMenu: String, CaseIterable {
    case all = "All"
    case chair = "Chair"
    case table = "Table"
    case lamp = "Lamp"
    case floor = "Floor"
}
