//
//  OnBoardingView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 18.09.2024.
//

import SwiftUI

struct OnBoardingView: View {
    
    @StateObject var viewModel = OnBoardingViewModel()
    
    @State var currentPage = 0
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                Color.blue.opacity(0.3).ignoresSafeArea()
                
                if viewModel.isOnboardingCompleted {
                    LoginView()
                } else {
                    TabView(selection: $currentPage) {
                        
                        ForEach(0..<3){ index in
                            VStack{
                                Spacer()
                                if index == 3 - 3 {
                                    ZStack {
                                        Rectangle()
                                            .frame(maxWidth: .infinity, maxHeight: 600)
                                            .foregroundColor(.blue.opacity(0.1))
                                            .cornerRadius(50)
                                            .overlay {
                                                RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                                                    .stroke(lineWidth: 2)
                                                    .foregroundColor(.blue.opacity(0.3))
                                                    .shadow(color: .blue, radius: 5)
                                            }
                                        VStack{
                                            Image(systemName: "figure.walk")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 200, maxHeight: 200)
                                                .foregroundColor(.blue.opacity(0.5))
                                                .padding()
                                            Text("Sağlıklı Yaşama Adım At!")
                                                .font(.title).bold()
                                                .foregroundStyle(Color.white.opacity(0.9))
                                                .padding(.horizontal)
                                            Text("Daha iyi bir yaşam tarzına kavuşmak hiç bu kadar kolay olmamıştı. \n\nSenin için kişiselleştirilmiş sağlık önerileri ve hedefler burada.")
                                                .padding()
                                                .font(.headline).bold()
                                                .foregroundColor(.black.opacity(0.7))
                                                .multilineTextAlignment(.leading)
                                            VStack{
                                                Image(systemName: "arrow.right")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(maxWidth: 30, maxHeight: 10)
                                                    .scaledToFill()
                                                    .padding(.top)
                                                    .scaleEffect(CGSize(width: 1.5, height: 1.0))
                                                    .foregroundColor(.blue.opacity(0.7))
                                                Text("Swipe")
                                                    .font(.headline).bold()
                                                    .foregroundColor(.blue.opacity(0.8))
                                            }
                                        }
                                    }
                                }
                                
                                if index == 3 - 2 {
                                    
                                    ZStack{
                                        
                                        Rectangle()
                                            .frame(maxWidth: .infinity, maxHeight: 600)
                                            .foregroundColor(.blue.opacity(0.1))
                                            .cornerRadius(50)
                                            .overlay {
                                                RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                                                    .stroke(lineWidth: 2)
                                                    .foregroundColor(.blue.opacity(0.3))
                                                    .shadow(color: .blue, radius: 5)
                                            }
                                        
                                        VStack{
                                            Image(systemName: "figure.run")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 200, maxHeight: 200)
                                                .foregroundColor(.blue.opacity(0.5))
                                                .padding()
                                            Text("Hedeflerini Belirle")
                                                .font(.title).bold()
                                                .foregroundStyle(Color.white.opacity(0.9))
                                                .padding(.horizontal)
                                            Text("Vücut kitle endeksini ve bazal metabolizma hızını öğrenerek işe koyul. \n\nAdım adım ilerleyerek hedeflerine ulaş.")
                                                .padding()
                                                .font(.headline).bold()
                                                .foregroundColor(.black.opacity(0.7))
                                                .multilineTextAlignment(.leading)
                                            VStack{
                                                Image(systemName: "arrow.right")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(maxWidth: 30, maxHeight: 10)
                                                    .scaledToFill()
                                                    .padding(.top)
                                                    .scaleEffect(CGSize(width: 1.5, height: 1.0))
                                                    .foregroundColor(.blue.opacity(0.7))
                                                Text("Swipe")
                                                    .font(.headline).bold()
                                                    .foregroundColor(.blue.opacity(0.8))
                                            }.padding(.top)
                                        }
                                    }
                                }
                                
                                if index == 3 - 1 {
                                    
                                    ZStack{
                                        
                                        Rectangle()
                                            .frame(maxWidth: .infinity, maxHeight: 600)
                                            .foregroundColor(.blue.opacity(0.1))
                                            .cornerRadius(50)
                                            .overlay {
                                                RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                                                    .stroke(lineWidth: 2)
                                                    .foregroundColor(.blue.opacity(0.3))
                                                    .shadow(color: .blue, radius: 5)
                                            }
                                        
                                        VStack{
                                            Image(systemName: "drop")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 200, maxHeight: 200)
                                                .foregroundColor(.blue.opacity(0.5))
                                                .padding()
                                            Text("Su İçmeyi Unutma")
                                                .font(.title).bold()
                                                .foregroundStyle(Color.white.opacity(0.9))
                                                .padding(.horizontal)
                                            Text("Vücudun için en önemli şeylerden biri su! \n\nGünlük su tüketimini takip et ve sağlıklı kal.")
                                                .padding()
                                                .font(.headline).bold()
                                                .foregroundColor(.black.opacity(0.7))
                                                .multilineTextAlignment(.leading)
                                            Button(action: {
                                                viewModel.isOnboardingCompleted = true
                                            }, label: {
                                                Text("Get Started")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color.blue)
                                                    .cornerRadius(10)
                                            }).padding().padding(.top)
                                        }
                                        
                                    }
                                    
                                }
                                Spacer()
                            }
                            .tag(index)
                            .padding()
                        }
                        
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                }
            }
        }
    }
}

#Preview {
    OnBoardingView()
}
