//
//  OnBoardingViewModel.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 18.09.2024.
//

import Foundation


class OnBoardingViewModel : ObservableObject {
    @Published var isOnboardingCompleted: Bool {
        didSet {
            UserDefaults.standard.set(isOnboardingCompleted, forKey: "onboardingCompleted")
        }
    }
    
    init() {
        self.isOnboardingCompleted = UserDefaults.standard.bool(forKey: "onboardingCompleted")
    }
}
