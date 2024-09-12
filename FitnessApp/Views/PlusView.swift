//
//  HomeView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 12.09.2024.
//

import SwiftUI

struct PlusView: View {
    
    @State private var showMenu = false
    @State var showSheet1 = false
    @State var showSheet2 = false
    @State var showSheet3 = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.3).ignoresSafeArea()

                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        ZStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 80, maxHeight: 80)
                                .foregroundColor(.blue.opacity(0.6))
                                .onTapGesture {
                                    withAnimation {
                                        showMenu.toggle()
                                    }
                                }
                            
                            if showMenu {
                                menuView
                                    .transition(.scale)
                            }
                        }
                    }
                    .padding(40)
                }
            }
            .onTapGesture {
                withAnimation {
                    showMenu = false
                }
            }
            .sheet(isPresented: $showSheet1) {
                BMRCalculatorView()
            }
            .sheet(isPresented: $showSheet2) {
                BMICalculatorView()
            }
            .sheet(isPresented: $showSheet3) {
                WaveAnimationView()
            }
        }
    }

    private var menuView: some View {
        VStack {
            Button(action: {
                showSheet1 = true
                withAnimation{
                    showMenu = false
                }
            }) {
                Text("BMR")
                    .font(.headline)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .padding(.horizontal)
            }
            
            Button(action: {
                showSheet2 = true
                withAnimation{
                    showMenu = false
                }
            }) {
                Text("BMI")
                    .font(.headline)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .padding(.horizontal)
            }
            Button(action: {
                showSheet3 = true
                withAnimation{
                    showMenu = false
                }
            }) {
                Text("Water Level")
                    .font(.headline)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .padding(.horizontal)
            }
        }
        .padding(40)
        .background(Color.blue.opacity(0.2))
        .clipShape(Circle())
        .shadow(radius: 20)
    }
}

#Preview {
    PlusView()
}
