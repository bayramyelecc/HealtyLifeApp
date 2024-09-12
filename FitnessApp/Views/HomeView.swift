//
//  HomeView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 14.09.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue.opacity(0.3).ignoresSafeArea()
                VStack{
                    TabView{
                        WaveAnimationView().environmentObject(authViewModel)
                            .tabItem {
                                Image(systemName: "house.fill")
                                Text("Home")
                            }
                        ProfileView()
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("Profile")
                            }
                    }.accentColor(.blue)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
