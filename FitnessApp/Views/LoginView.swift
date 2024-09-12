//
//  LoginView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 12.09.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var fullName = ""
    @State var pickerShow = false
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue.opacity(0.3).ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("LOGIN")
                        .padding()
                        .font(.system(size: 60))
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .shadow(color: .black, radius: 10)
                        .background(.blue.opacity(0.1))
                        .cornerRadius(30)
                        .shadow(color: .black, radius: 10)
                        .overlay(content: {
                            RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                                .stroke(lineWidth: 2)
                                .foregroundColor(.blue.opacity(0.3))
                                .shadow(color: .blue, radius: 5)
                        })
                        .padding()
                        .offset(y: 70)
                    
                    ZStack {
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(maxWidth: .infinity, maxHeight: 350)
                                .cornerRadius(30)
                                .shadow(color: .black, radius: 10)
                                .overlay(content: {
                                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.blue.opacity(0.3))
                                        .shadow(color: .blue, radius: 5)
                                })
                                .padding(.horizontal)
                            Spacer()
                        }
                        VStack{
                            Spacer()
                            TextField("", text: $email, prompt: Text("E-mail").font(.headline).bold().foregroundStyle(Color.black.opacity(0.5)))
                                .padding()
                                .background(.white)
                                .cornerRadius(30)
                                .autocapitalization(.none)
                                .overlay{
                                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                                        .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                                }
                                .shadow(color: .black, radius: 10)
                            SecureField("", text: $password, prompt: Text("Password").font(.headline).bold().foregroundStyle(Color.black.opacity(0.5)))
                                .padding()
                                .background(.white)
                                .cornerRadius(30)
                                .autocapitalization(.none)
                                .overlay{
                                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                                        .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                                }
                                .shadow(color: .black, radius: 10)
                            Button(action: {
                                authViewModel.signIn(email: email, password: password)
                            }, label: {
                                Text("Login")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(Color.black.opacity(0.7))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.white)
                                    .cornerRadius(30)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                                    }
                                    .shadow(color: .black, radius: 10)
                            })
                            Spacer()
                        }.padding(35)
                    }
                    Text("Hesabın yok mu ?")
                        .font(.headline)
                        .bold()
                    Button(action: {
                        pickerShow = true
                    }, label: {
                        Text("Kayıt Ol")
                    })
                    .sheet(isPresented: $pickerShow, content: {
                        RegisterView()
                    })
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
