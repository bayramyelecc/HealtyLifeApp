//
//  CalculatorView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 12.09.2024.
//

import SwiftUI

struct BMICalculatorView: View {
    
    @StateObject var viewModel = BMICalculatorViewModel()
    
    @State var showAlert = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.blue.opacity(0.3).ignoresSafeArea()
                VStack{

                    VStack{
                        Text("Boy : \(String(format: "%.2f", viewModel.userBoy)) m")
                            .font(.title)
                            .bold()
                            .padding()
                        Slider(value: $viewModel.userBoy, in: 1.50...2.00)
                        {
                        } minimumValueLabel: {
                            Text("1.50")
                                .font(.headline)
                                .bold()
                        } maximumValueLabel: {
                            Text("2.00")
                                .font(.headline)
                                .bold()
                        }
                        .foregroundColor(.black.opacity(0.9))
                        .accentColor(.blue.opacity(0.3))
                        
                        Text("Kilo: \(Int(viewModel.userKilo)) kg")
                            .font(.title)
                            .bold()
                            .padding()
                        Slider(value: $viewModel.userKilo, in: 50...150){
                            Text("fgsfgsdfg")
                        } minimumValueLabel: {
                            Text("50")
                                .font(.headline)
                                .bold()
                        } maximumValueLabel: {
                            Text("150")
                                .font(.headline)
                                .bold()
                        }
                        .foregroundColor(.black.opacity(0.9))
                        .accentColor(.blue.opacity(0.3))

                        Button(action: {
                            showAlert = true
                            viewModel.calculate()
                        }, label: {
                            Text("Hesapla")
                                .padding()
                                .font(.title)
                                .bold()
                                .foregroundColor(.white.opacity(0.8))
                                .frame(maxWidth: .infinity)
                                .background(.blue.opacity(0.3))
                                .cornerRadius(10)
                        })
                        .padding()
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("BMI: \(String(format: "%.1f", viewModel.bmiSonuc))\nDurum: \(viewModel.sonucMesaji.rawValue)"), message: Text(viewModel.sonucAciklamasi.rawValue), dismissButton: .default(Text("Tamam")))
                        })
                        
                        Group {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.blue.opacity(0.3))
                                    .cornerRadius(30)
                                    .frame(maxWidth: 400, maxHeight: 250)
                                    .overlay{
                                        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                                            .stroke(lineWidth: 3)
                                            .foregroundColor(.black.opacity(0.1))
                                    }
                                    .shadow(color: .blue, radius: 10)
                                    .padding()
                                VStack(alignment: .leading) {
                                    Text("18.5 ve altı Düşük Kilolu")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.vertical,1)
                                        
                                    Text("18.5 - 24.9 Normal Kilolu")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.vertical,1)
                                        
                                    Text("25-29.9 Fazla Kilolu")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.vertical,1)
                                        
                                    Text("30-40 Obez")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.vertical,1)
                                        
                                    Text("40 ve üstü Aşırı Obez")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.vertical,1)
                                        
                                }
                            }
                        }
                            
                    }.padding()
                    Spacer()
                }
            }
            .navigationTitle("BMI Calculator")
        }
    }
}

#Preview {
    BMICalculatorView()
}


