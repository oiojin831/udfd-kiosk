//
//  ShowCheckInDataView.swift
//  udfd-kiosk
//
//  Created by Eung Jin Lee on 2019/11/26.
//  Copyright © 2019 undefinedist. All rights reserved.
//

import SwiftUI

struct ShowCheckInDataView: View {
    @Binding var reservations: [resDatatype]

    @ViewBuilder
    var body: some View {
        if (!reservations.isEmpty) {
             VStack {
                Text(reservations[0].checkInDate)
                Text(reservations[0].guestName)
                Text(reservations[0].guestHouseName)
            }
        } else {
             Text("Loading...")
        }
    }
}

