//
//  Reservation.swift
//  udfd-kiosk
//
//  Created by Eung Jin Lee on 2019/11/22.
//  Copyright © 2019 undefinedist. All rights reserved.
//

import Foundation

struct Reservation {
    let guestName: String
    let guestHouseName: String
    let checkInDate: String
}

extension Reservation {
    static func all() -> [Reservation] {
        return [
            Reservation(guestName: "ueng", guestHouseName: "dmyk", checkInDate: "2019-03-03"),
            Reservation(guestName: "uewng", guestHouseName: "dmyk", checkInDate: "2019-03-03"),
            Reservation(guestName: "uew2ng", guestHouseName: "dmyk", checkInDate: "2019-03-03")
        ]
    }
}
