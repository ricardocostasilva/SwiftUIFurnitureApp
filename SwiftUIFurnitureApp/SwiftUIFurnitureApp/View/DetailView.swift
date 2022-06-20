//
//  DetailView.swift
//  SwiftUIFurnitureApp
//
//  Created by ricardo silva on 08/06/2022.
//

import SwiftUI

struct DetailView: View {
    var furniture: Furniture
    var animation: Namespace.ID
    @EnvironmentObject var appViewModel: AppViewModel
    
    @State var showDetailContent: Bool = false
    @State var activeColor: String = "Color1"
    @State var cartCount: Int = 0
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            VStack{
                HStack{
                    Button {
                        withAnimation(.easeInOut) {
                            showDetailContent = false
                        }
                        withAnimation(.easeInOut) {
                            appViewModel.showDetailView = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("Black"))
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(.red)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            }
                    }

                }
                .padding()
                .opacity(showDetailContent ? 1 : 0)
                
                Image(furniture.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: furniture.id + "IMAGE", in: animation)
                    .frame(height: size.height/3)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(furniture.title)
                                .font(.title.bold())
                                .fixedSize()
                                .foregroundColor(Color("Black"))
                                .matchedGeometryEffect(id: furniture.title + "TITLE", in: animation)
                            
                            Text("by Ricardo")
                                .font(.caption2)
                                .bold()
                                .fixedSize()
                                .lineLimit(1)
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: furniture.title + "SUBTITLE", in: animation)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Label {
                            Text("4.7")
                                .font(.callout)
                                .fontWeight(.bold)
                        } icon: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background {
                            Capsule()
                                .strokeBorder(Color("Black").opacity(0.2), lineWidth: 1)
                        }
                        .scaleEffect(0.8)
                    }
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical)
                    
                    HStack(spacing: 10) {
                        Text("Color")
                            .font(.callout.bold())
                            .foregroundColor(Color("Black"))
                            .padding(.trailing, 10)
                        
                        ForEach(["Color1", "Color2", "Color3"], id: \.self) { color in
                            Circle()
                                .fill(Color(color))
                                .frame(width: 20, height: 20)
                                .background {
                                    Circle()
                                        .strokeBorder(Color("Black"))
                                        .padding(-4)
                                        .opacity(activeColor == color ? 1 : 0)
                                }
                                .onTapGesture {
                                    activeColor = color
                                }
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Image(systemName: "minus")
                                .onTapGesture {
                                    if cartCount > 0 { cartCount -= 1 }
                                }
                            Text("\(cartCount)")
                            
                            Image(systemName: "plus")
                                .onTapGesture {
                                    cartCount += 1
                                }
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("Black"))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background {
                            Capsule()
                                .fill(Color("Black").opacity(0.1))
                        }
                    }
                    
                    Spacer(minLength: 5)
                    
                    Rectangle()
                        .fill(Color("Black").opacity(0.1))
                        .frame(height: 1)
                    
                    HStack{
                        Text(furniture.price)
                            .font(.largeTitle.bold())
                            .foregroundColor(Color("Black"))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Buy Now")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal, 30)
                                .background {
                                    Capsule()
                                        .fill(Color("Orange"))
                                }
                        }

                    }
                    .padding(.bottom, 5)
                }
                .padding(.top, 35)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                }
                .opacity(showDetailContent ? 1 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background {
            Color("BG")
                .ignoresSafeArea()
                .opacity(showDetailContent ? 1 : 0)
        }
        .onAppear{
            withAnimation(.easeInOut) {
                showDetailContent = true
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
