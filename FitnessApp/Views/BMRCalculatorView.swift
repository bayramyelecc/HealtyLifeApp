//
//  BMRCalculatorView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 14.09.2024.
//

import SwiftUI

struct BMRCalculatorView: View {
    
    @State var showSheet = false
    @State var showAlert = false
    
    @StateObject var viewModel = BMRCalculatorViewModel()
    
    @State var buttonActive = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue.opacity(0.3).ignoresSafeArea()
                VStack{
                    HStack {
                        VStack {
                            Text("Erkek")
                                .font(.title)
                                .bold()
                                .padding(.trailing)
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: 200, maxHeight: 150)
                                    .padding(.trailing)
                                    .foregroundColor(viewModel.selecteMale ? .blue.opacity(0.7) : .blue.opacity(0.3))
                                    .cornerRadius(30)
                                    .onTapGesture {
                                        viewModel.selecteMale = true
                                        viewModel.selectFemale = false
                                    }
                                    .shadow(color: .blue, radius: 10)
                                Image(systemName: "mustache.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .padding(.trailing)
                                    .foregroundColor(.white.opacity(0.6))
                                    .onTapGesture {
                                        viewModel.selecteMale = true
                                        viewModel.selectFemale = false
                                    }
                            }
                        }
                        VStack {
                            Text("Kadın")
                                .font(.title)
                                .bold()
                                .padding(.leading)
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: 200, maxHeight: 150)
                                    .padding(.leading)
                                    .foregroundColor(viewModel.selectFemale ? .blue.opacity(0.7) : .blue.opacity(0.3))
                                    .cornerRadius(30)
                                    .onTapGesture {
                                        viewModel.selectFemale = true
                                        viewModel.selecteMale = false
                                    }
                                    .shadow(color: .blue, radius: 10)
                                Image(systemName: "mouth.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .padding(.leading)
                                    .foregroundColor(.white.opacity(0.6))
                                    .onTapGesture {
                                        viewModel.selectFemale = true
                                        viewModel.selecteMale = false
                                    }
                            }
                        }
                    }.padding()
                    
                    
                    Text("Boy : \(String(format: "%.2f", viewModel.boy)) m")
                        .font(.title)
                        .bold()
                    
                    
                    Slider(value: $viewModel.boy, in: 1.50...2.00){}
                minimumValueLabel: {
                    Text("1.50")
                } maximumValueLabel: {
                    Text("2.00")
                }
                    
                    Text("Kilo : \(Int(viewModel.kilo)) kg")
                        .font(.title)
                        .bold()
                    
                    Slider(value: $viewModel.kilo, in: 50...150){}
                minimumValueLabel: {
                    Text("50")
                } maximumValueLabel: {
                    Text("150")
                }
                    
                    Text("Yaş : \(Int(viewModel.yas))")
                        .font(.title)
                        .bold()
                    
                    Slider(value: $viewModel.yas, in: 15...90){}
                minimumValueLabel: {
                    Text("15")
                } maximumValueLabel: {
                    Text("90")
                }
                    
                    Picker("Hareket Seviyeniz : ", selection: $viewModel.selectedHareket) {
                        ForEach(viewModel.hareketSeviyesi, id: \.self) {
                            Text($0)
                                .font(.headline)
                                .bold()
                        }
                    }.pickerStyle(NavigationLinkPickerStyle()).padding(.horizontal)
                    
                    Button(action: {
                        if viewModel.selectFemale == false && viewModel.selecteMale == false{
                            showAlert = true
                        } else if viewModel.selectFemale == true || viewModel.selecteMale == true {
                            viewModel.calculate()
                            showSheet = true
                        }
                        
                    }, label: {
                        Text("Hesapla")
                            .font(.title2)
                            .bold()
                            .padding()
                            .foregroundStyle(Color.white.opacity(0.8))
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.5))
                            .cornerRadius(10)
                    })
                    
                    .padding(.vertical)
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("HATA"), message: Text("Lütfen cinsiyet seçiniz!!"), dismissButton: .destructive(Text("Tamam")))
                    }
                    .sheet(isPresented: $showSheet, content: {
                        ZStack {
                            Color.blue.opacity(0.3).ignoresSafeArea()
                            VStack {
                                Text("BMR: ")
                                    .font(.title)
                                    .bold()
                                    .padding(.horizontal)
                                Text("\(String(format: "%.f", viewModel.sonucBmr)) KCal")
                                    .font(.title)
                                    .bold()
                                    .padding(.horizontal)
                                
                                Text(viewModel.sonucMesaji)
                                    .font(.headline)
                                    .bold()
                                    .padding()
                                
                                
                                Button("Tamam") {
                                    showSheet = false
                                }
                                .padding()
                                .background(Color.blue.opacity(0.5))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                            .padding()
                        }
                    })
                    
                    Spacer()
                }.padding()
            }
            .navigationTitle("BMR Calculator")
        }
    }
}

#Preview {
    BMRCalculatorView()
}
