//
//  AgreementView.swift
//  udfd-kiosk
//
//  Created by Eung Jin Lee on 2019/11/25.
//  Copyright © 2019 undefinedist. All rights reserved.
//

import SwiftUI

struct AgreementView: View {
    @EnvironmentObject var obser: observer
    var order: Int

    var body: some View {
        let index : Int = obser.instructions.firstIndex(where: {$0.order == order})!
        return VStack {
            Text(obser.instructions[index].agree)
            Text(String(order))
            NavigationLink(destination: ConfirmReservationView(newIndex: index)) {
                Text("Agree")
            }
        }
    }
}

struct AgreementView_Previews: PreviewProvider {
    static var previews: some View {
        AgreementView(order: 1)
    }
}
