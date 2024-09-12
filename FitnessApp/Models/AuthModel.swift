//
//  AuthModel.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 12.09.2024.
//

import Foundation

struct AuthModel : Identifiable, Codable {
    
    var id: String
    var fullName: String
    var email: String
    var dueDate: Date
    
}
