//
//  AuthViewModel.swift
//  FitnessApp
//
//  Created by Bayram Yeleç on 12.09.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject{
    
    @Published var isSignedIn : Bool = false
    @Published var currentUser : AuthModel?
    @Published var fullName : String = ""
    
    private let db = Firestore.firestore()
    
    init(){
        isSignedIn = Auth.auth().currentUser != nil
        if let user = Auth.auth().currentUser{
            fetchUser(uid: user.uid)
        }
    }
    
    func register(email: String, password: String, fullName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                print("Hata var")
            } else if let user = result?.user {
                let dueDate = Date()
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = fullName
                
                changeRequest.commitChanges { error in
                    if error != nil {
                        print("Profil güncelleme hatası: \(error?.localizedDescription ?? "")")
                    } else {
                        print("Kullanıcı profili başarıyla güncellendi.")
                    }
                }
                
                self?.saveUser(uid: user.uid, fullName: fullName, email: email, dueDate: dueDate)
                self?.fetchUser(uid: user.uid)
                self?.isSignedIn = true
            }
        }
    }
    
    
    func saveUser(uid: String, fullName: String, email: String, dueDate: Date){
        db.collection("users").document(uid).setData([
            "fullName" : fullName,
            "email" : email,
            "dueDate" : dueDate
        ]) { error in
            print("Kaydetme hatası")
        }
    }
    
    func fetchUser(uid: String){
        db.collection("users").document(uid).addSnapshotListener { [weak self] document, error in
            if let document = document, document.exists {
                let data = document.data()
                let fullName = data?["fullName"] as? String ?? ""
                let email = data?["email"] as? String ?? ""
                let dueDate = (data?["dueDate"] as? Timestamp)?.dateValue() ?? Date()
                self?.currentUser = AuthModel(id: uid, fullName: fullName, email: email, dueDate: dueDate)
                self?.fullName = fullName
            } else {
                print("veriler alınırken bir hata oluştu")
            }
        }
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                print("Hata")
            } else if let user = result?.user {
                self?.fetchUser(uid: user.uid)
                self?.isSignedIn = true
            }
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            self.currentUser = nil
            UserDefaults.standard.removeObject(forKey: "savedWaterLevel")
            UserDefaults.standard.removeObject(forKey: "savedCins")
        } catch {
            print("cıkıs hatası")
        }
    }
    
}
