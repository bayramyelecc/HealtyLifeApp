//
//  BMRCalculatorViewModel.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 14.09.2024.
//

import Foundation


class BMRCalculatorViewModel : ObservableObject {
    
    @Published var selecteMale = false
    @Published var selectFemale = false
    
    @Published var kilo = 75.0
    @Published var boy = 1.75
    @Published var yas = 20.0
    
    @Published var selectedHareket = ""
    let hareketSeviyesi = [
        "Masa başı ve durağan bir yaşamım var.",
        "Hafif düzeyde hareketliyim.",
        "Orta düzeyde hareketli olup çok oturmuyorum.",
        "Yüksek düzeyde aktifim ve düzenli spor yapıyorum"
    ]
    
    @Published var sonucBmr : Double = 0.0
    @Published var sonucMesaji = ""
    
    
    func calculate(){
        if selecteMale == true && selectFemale == false {
            sonucBmr = 66.5 + (13.75 * kilo) + (5 * boy * 100) - (6.77 * yas)
        } else if selecteMale == false && selectFemale == true {
            sonucBmr = 655.1 + (9.56 * kilo) + (1.85 * boy * 100) - (4.67 * yas)
        }
        
        let hareketFaktoru: Double
        
        switch selectedHareket {
        case "Masa başı ve durağan bir yaşamım var.":
            hareketFaktoru = 1.2
        case "Hafif düzeyde hareketliyim.":
            hareketFaktoru = 1.3
        case "Orta düzeyde hareketli olup çok oturmuyorum.":
            hareketFaktoru = 1.4
        case "Yüksek düzeyde aktifim ve düzenli spor yapıyorum":
            hareketFaktoru = 1.5
        default:
            hareketFaktoru = 1.2
        }
        
        sonucBmr *= hareketFaktoru
        
        sonucMesaji = String(
            format: """
            Günlük kalori ihtiyacınız: %.f KCal.
            
            Kilo vermek için: %.f KCal
            Kilo almak için: %.f KCal
            
            Sağlıklı kalmak için dengeli bir diyet ve düzenli egzersiz önerilir.
            """,
            sonucBmr,
            sonucBmr - 500,
            sonucBmr + 500
        )


        
    }
    
}
