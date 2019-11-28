//
//  ConfirmReservationView.swift
//  udfd-kiosk
//
//  Created by Eung Jin Lee on 2019/11/26.
//  Copyright © 2019 undefinedist. All rights reserved.
//

import SwiftUI
import Firebase

struct ConfirmReservationView: View {
    @EnvironmentObject var obser: observer
    @ObservedObject var resObser = resObserver()
    
    @State private var reservationCode: String = ""
    @State private var isModal: Bool = false
    private var index: Int
    
    init(newIndex: Int) {
        self.index = newIndex
    }
    


    var body: some View {
        VStack {
                Text("Reservation Code")
                    .font(.headline)
            TextField(obser.instructions[self.index].reservationCodePlaceholder, text: $reservationCode)
                    .padding(.all)
                Button(action: {
                    self.resObser.fetchReservation(reservationCode: self.reservationCode)
                    self.isModal = true
                }) {
                    Text("Hello")
                }.sheet(isPresented: $isModal, content: {
                    ShowCheckInDataView(reservations: self.$resObser.reservations)
                })
            }.padding(.horizontal, 15)
        
    }
}

//struct ConfirmReservationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfirmReservationView(obser: 1, isModal: resObserver(), resObser: resObserver(), index: 1)
//    }
//}


//view model
class resObserver : ObservableObject {
    
    @Published var reservations = [resDatatype]()
    let db = Firestore.firestore()

    func fetchReservation(reservationCode: String) {
        db.collection("reservations").whereField("reservationCode", isEqualTo: reservationCode).getDocuments() { (snap, err) in
            guard let snap = snap else {
                print("Error retreving cities: \(err.debugDescription)")
                return
            }
        
            self.reservations = []
            for i in snap.documents {
                let id = i.documentID
                let checkInDate = i.get("checkInDate") as! String
                let checkInTime = i.get("checkInTime") as! Int
                let checkOutDate = i.get("checkOutDate") as! String
                let checkOutTime = i.get("checkOutTime") as! Int
                let guestName = i.get("guestName") as! String
                let guestHouseName = i.get("guestHouseName") as! String
                let platform = i.get("platform") as! String
                let price = i.get("price") as! String

                
                self.reservations.append(resDatatype(id: id, checkInDate: checkInDate, checkInTime: checkInTime, checkOutDate: checkOutDate, checkOutTime: checkOutTime, guestName: guestName,guestHouseName: guestHouseName, platform: platform, price: price))
                print("insid")
                print(self.reservations)
            }
        }
    }
    
}

struct resDatatype : Identifiable {
    
    var id : String
    var checkInDate : String
    var checkInTime : Int
    var checkOutDate : String
    var checkOutTime : Int
    var guestName : String
    var guestHouseName : String
    var platform : String
    var price : String
}

