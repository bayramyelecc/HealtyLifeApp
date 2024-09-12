//
//  BMICalculatorViewModel.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 13.09.2024.
//

import Foundation

class BMICalculatorViewModel : ObservableObject {
    
    @Published var userBoy : Double = 1.75
    @Published var userKilo : Double = 75.0
    @Published var bmiSonuc: Double = 0.0
    @Published var sonucMesaji : sonuclar = .normalKilolu
    @Published var sonucAciklamasi : sonucAciklama = .normalKiloluk
    
    func calculate(){
        bmiSonuc = userKilo / (userBoy * userBoy)
        sonucMesaji = sonucBMIMesaji(bmiSonuc: bmiSonuc)
        sonucAciklamasi = sonucBMIAciklamasi(bmiSonuc: bmiSonuc)
    }
    
    func sonucBMIMesaji(bmiSonuc: Double) -> sonuclar {
        switch bmiSonuc {
        case ...18.5:
            return .zayif
        case 18.5..<25:
            return .normalKilolu
        case 25..<30:
            return .fazlaKilolu
        case 30..<35:
            return .obez1
        case 35..<40:
            return .obez2
        default:
            return .obez3
        }
    }
    
    func sonucBMIAciklamasi(bmiSonuc: Double) -> sonucAciklama {
        switch bmiSonuc {
        case ...18.5:
            return .zayiflik
        case 18.5..<25:
            return .normalKiloluk
        case 25..<30:
            return .fazlaKiloluk
        case 30..<35:
            return .obezlik1
        case 35..<40:
            return .obezlik2
        default:
            return .obezlik3
        }
    }
    
    enum sonuclar : String {
        case zayif = "Zayıf"
        case normalKilolu = "Normal Kilolu"
        case fazlaKilolu = "Fazla Kilolu"
        case obez1 = "Obez(1. Derece Obezite)"
        case obez2 = "Aşırı Obez(2. Derece Obezite)"
        case obez3 = "Morbid Obez(3. Derece Obezite)"
        
    }
    
    enum sonucAciklama : String {
        case zayiflik = "Kilo almak gerekebilir."
        case normalKiloluk = "Sağlıklı kilodasınız."
        case fazlaKiloluk = "Kilo vermek faydalı olabilir."
        case obezlik1 = "Obezite ile ilişkili sağlık riskleri artmaya başlamış olabilir."
        case obezlik2 = "Sağlık riskleri ciddi seviyede."
        case obezlik3 = "Yüksek sağlık riskleri taşıyorsunuz, tıbbi müdahale gerekli olabilir."
    }
    
    
}
