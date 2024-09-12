//
//  ContentView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 12.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    @StateObject var viewModel = OnBoardingViewModel()
    
    var body: some View {
        
        if viewModel.isOnboardingCompleted {
            if authViewModel.isSignedIn {
                HomeView().environmentObject(authViewModel)
            } else {
                LoginView().environmentObject(authViewModel)
            }
        } else {
            OnBoardingView().environmentObject(authViewModel)
        }
        
        
    }
}

#Preview {
    ContentView()
}
