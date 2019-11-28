//
//  ContentView.swift
//  udfd-kiosk
//
//  Created by Eung Jin Lee on 2019/11/22.
//  Copyright © 2019 undefinedist. All rights reserved.
//

import SwiftUI
import Firebase


struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("J Honor GuestHouse")
                LanguageView()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LanguageView : View {
    
    @EnvironmentObject var obser: observer

    var body : some View {
        VStack {
            ForEach(obser.instructions.sorted { $0.order < $1.order }) { instruction in
                NavigationLink(destination: AgreementView(order: instruction.order)) {
                    HStack {
                        Image(instruction.language)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, 50)
                    }
                    Text(instruction.checkInInstruction).fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

class observer : ObservableObject {
    
    @Published var instructions = [datatype]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("instructions").whereField("guestHouseName", isEqualTo: "jhonor").addSnapshotListener { (snap, err) in
            guard let snap = snap else {
                print("Error retreving cities: \(err.debugDescription)")
                return
            }
            
            self.instructions = []

            for i in snap.documents {
                
                let guestHouseName = i.get("guestHouseName") as! String
                let checkInInstruction = i.get("checkInInstruction") as! String
                let language = i.get("language") as! String
                let agree = i.get("agree") as! String
                let reservationCodePlaceholder = i.get("reservationCodePlaceholder") as! String
                let order = i.get("order") as! Int
                let id = i.documentID
                
                self.instructions.append(datatype(id: id, guestHouseName: guestHouseName, checkInInstruction: checkInInstruction, language: language, order: order, agree: agree, reservationCodePlaceholder: reservationCodePlaceholder))
            }
        }
    }
    
}

struct datatype : Identifiable {
    
    var id : String
    var guestHouseName : String
    var checkInInstruction : String
    var language : String
    var order : Int
    var agree : String
    var reservationCodePlaceholder : String
}

