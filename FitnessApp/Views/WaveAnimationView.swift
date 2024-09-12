//
//  WaterWaveView.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 17.09.2024.
//

import SwiftUI

struct WaveAnimationView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    @State private var waveOffset: CGFloat = 0.0
    @State private var waterLevel: CGFloat = {
            UserDefaults.standard.object(forKey: "savedWaterLevel") as? CGFloat ?? 0.0
        }()
    
    
    @State private var selectedGender: String? = {
        UserDefaults.standard.object(forKey: "savedCins") as? String ?? nil
    }()
    
    
    @State private var showMenu = false
    @State var showSheet1 = false
    @State var showSheet2 = false
    
    @State var showAlert = false
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.blue.opacity(0.3)
                    .ignoresSafeArea()
                
                VStack {
                    HStack() {
                        RadioButton(text: "Kadın", isSelected: selectedGender == "Kadın") {
                            selectedGender = "Kadın"
                            UserDefaults.standard.set(selectedGender, forKey: "savedCins")
                            
                        }
                        
                        RadioButton(text: "Erkek", isSelected: selectedGender == "Erkek") {
                            selectedGender = "Erkek"
                            UserDefaults.standard.set(selectedGender, forKey: "savedCins")
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .padding(.horizontal,15)
                    .cornerRadius(10)
                    .overlay(content: {
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .stroke(lineWidth: 2)
                            .foregroundColor(.blue.opacity(0.2))
                            .shadow(color: .blue, radius: 5)
                            .padding(.horizontal,15)
                    })
                    .padding(.horizontal)
                    
                    GeometryReader { geometry in
                        ZStack {
                            let containerWidth = geometry.size.width / 1.2
                            let containerHeight = geometry.size.height / 1.5
                            let bottleWidth = geometry.size.width / 1.5
                            let bottleHeight = geometry.size.height / 2
                            let textWidth = geometry.size.width / 5
                            let textHeight = geometry.size.height / 5
                            
                            Rectangle()
                                .frame(width: containerWidth, height: containerHeight)
                                .cornerRadius(30)
                                .foregroundColor(.blue.opacity(0.05))
                                .overlay {
                                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.blue.opacity(0.2))
                                }
                                .padding()
                                .shadow(color: .blue, radius: 5)
                            
                            Image("bottle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: bottleWidth, height: bottleHeight)
                                .shadow(radius: 10)
                                .overlay(
                                    WaveShape(offset: waveOffset, waterLevel: waterLevel)
                                        .fill(Color.blue.opacity(0.6))
                                        .mask(
                                            Image("bottle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: bottleWidth, height: bottleHeight)
                                        )
                                )
                            
                            Text("\(Int(waterLevel * 100))%")
                                .font(.headline)
                                .font(.system(size: geometry.size.width / 20))
                                .bold()
                                .frame(width: textWidth, height: textHeight)
                                .padding()
                                .offset(y: bottleHeight / 4)
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: UIScreen.main.bounds.height / 2)
                    
                    Stepper("Water Level", value: $waterLevel, in: 0...1, step: selectedGender == "Erkek" ? 0.065 : 0.084) {_ in
                        
                        if selectedGender == nil {
                            showAlert = true
                        } else {
                            UserDefaults.standard.set(waterLevel, forKey: "savedWaterLevel")
                        }
                        
                        
                        
                        Text("Water Level: \(Int(waterLevel * 100))%")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    .offset(y: -80)
                    .onChange(of: waterLevel) {
                        withAnimation(.linear(duration: 0.1)) {}
                    }
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Uyarı"), message: Text("Lütfen Cinsiyet Seçiniz.."), dismissButton: .default(Text("Tamam")))
                    }
                    
                    VStack {
                        GeometryReader(content: { geometry in
                            
                            let containerWidth = geometry.size.width / 1.1
                            let containerHeight = geometry.size.height / 0.7
                            
                            Rectangle()
                                .frame(width: containerWidth, height: containerHeight)
                                .cornerRadius(30)
                                .foregroundColor(.blue.opacity(0.05))
                                .overlay {
                                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.blue.opacity(0.2))
                                }
                                .padding()
                                .shadow(color: .blue, radius: 5)
                                .overlay(
                                    ScrollView {
                                        VStack(alignment: .leading) {
                                            
                                            Text("Ortalama bir insanın günlük su ihtiyacı, çeşitli faktörlere bağlı olarak değişebilir. Ancak genel bir kılavuz olarak: \n\n-  Kadınlar için: Günde yaklaşık 2.7 litre (yaklaşık 11 bardak) \n\n-  Erkekler için: Günde yaklaşık 3.7 litre (yaklaşık 15 bardak) \n\n1 bardak (250 ml) su, günlük su ihtiyacının yaklaşık %8'ini karşılar.")
                                                .font(.headline).bold()
                                                .foregroundColor(.black.opacity(0.7))
                                                .padding()
                                                .multilineTextAlignment(.leading)
                                            
                                        }
                                        .padding()
                                    }.padding()
                                )
                        })
                        .offset(y: -70)
                        .onTapGesture {
                            withAnimation {
                                showMenu = false
                            }
                        }
                        
                    }.padding()
                }
                .onAppear {
                    
                    if let savedWaterLevel = UserDefaults.standard.object(forKey: "savedWaterLevel") as? CGFloat {
                        waterLevel = savedWaterLevel
                    }
                    
                    withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        waveOffset = 360
                    }
                }
                
                
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack{
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
                }.padding(.horizontal)
                    .sheet(isPresented: $showSheet1) {
                        BMRCalculatorView()
                    }
                    .sheet(isPresented: $showSheet2) {
                        BMICalculatorView()
                    }
                    
            }
            
            .navigationTitle("Water Level")
        }
    }
    
    struct WaveShape: Shape {
        var offset: CGFloat
        var waterLevel: CGFloat
        
        var animatableData: AnimatablePair<CGFloat, CGFloat> {
            get { AnimatablePair(offset, waterLevel) }
            set {
                offset = newValue.first
                waterLevel = newValue.second
            }
        }
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let waveHeight: CGFloat = 7
            let waterHeight = rect.height * (1 - waterLevel)
            
            path.move(to: CGPoint(x: 0, y: waterHeight))
            
            for x in stride(from: 0, to: rect.width, by: 1) {
                let y = sin((x + offset) * .pi / 180) * waveHeight + waterHeight
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.closeSubpath()
            
            return path
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
        }
        .padding()
        .background(Color.blue.opacity(0.2))
        .clipShape(Circle())
        .shadow(radius: 20)
    }
}


struct RadioButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Circle()
                    .strokeBorder(isSelected ? Color.blue : Color.gray, lineWidth: 2)
                    .background(Circle().fill(isSelected ? Color.blue.opacity(0.5) : Color.clear))
                    .frame(width: 20, height: 20)
                
                Text(text)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.vertical, 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    WaveAnimationView()
}
