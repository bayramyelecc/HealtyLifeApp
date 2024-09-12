//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 12.09.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    
    private var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter
        }

    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue.opacity(0.3).ignoresSafeArea()
                VStack {
                    if let user = authViewModel.currentUser {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .padding()
                            .clipShape(Circle())
                            .overlay(content: {
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .shadow(color: .black, radius: 10)
                            }).foregroundColor(.white.opacity(0.5))
                            .padding()
                        Text(user.fullName)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 2)
                        Text(user.email)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.bottom, 2)
                        HStack {
                            Text("Kayıt Tarihi:")
                                .font(.headline)
                            
                            Text(dateFormatter.string(from: user.dueDate))
                                .padding()
                        }
                        .padding()
                    }
                    Button(action: {
                        authViewModel.signOut()
                    }, label: {
                        Text("Çıkış Yap")
                            .font(.headline).bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue.opacity(0.5))
                            .cornerRadius(15)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal)
                    })
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(15)
                .overlay(content: {
                    RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .stroke(lineWidth: 2)
                        .foregroundColor(.blue.opacity(0.3))
                        .shadow(color: .blue, radius: 10)
                })
                .padding()
            }
        }
        
        
        
    }
}


#Preview {
    ProfileView()
}
