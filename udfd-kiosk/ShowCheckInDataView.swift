//
//  ShowCheckInDataView.swift
//  udfd-kiosk
//
//  Created by Eung Jin Lee on 2019/11/26.
//  Copyright © 2019 undefinedist. All rights reserved.
//

import SwiftUI
import sam4sPrtSdk

let passcode = [
        "jhonor101A":"5437*",
        "jhonor101B":"2403*",
        "jhonor101C":"3479*",
        "jhonor101D":"9893*",
        "jhonor201A":"5216*",
        "jhonor201B":"6593*",
        "jhonor201C":"1269*",
        "jhonor201D":"7508*",
        "jhonor202A":"2674*",
        "jhonor202B":"8086*",
        "jhonor202C":"0359*",
        "jhonor202D":"1410*",
        "jhonor301A":"5272*",
        "jhonor301B":"8625*",
        "jhonor301C":"7505*",
        "jhonor301D":"0430*",
        "jhonor302A":"6236*",
        "jhonor302B":"1774*",
        "jhonor302C":"3120*",
        "jhonor302D":"0288*",
        "jhonor302X":"0302*"
     ]

struct ShowCheckInDataView: View {
    @Binding var reservations: [resDatatype]

    @ViewBuilder
    var body: some View {
        if (!reservations.isEmpty) {
              VStack {
                Text(reservations[0].checkInDate)
                Text(reservations[0].guestName)
                Text(reservations[0].guestHouseName)
              }.onAppear {
                print(self.reservations[0].checkInDate)
                let prt_sdk = Sam4sPrintSdk.init()
                if(prt_sdk.get_connect_status()) {
                    _ = prt_sdk.printer_connect(ip_string: "192.168.0.253", n_port: 6001,nTimeout: 10);

                    prt_sdk.init_send_buffer()
                    var a = prt_sdk.set_font_size(width: 1, height: 1)
    
                    a = prt_sdk.set_left_margine(dpi: 180,inch: 1)
                         
         
                      
                    a = prt_sdk.set_font_bold(on_off: true)
                    a = prt_sdk.set_font_inverse(on_off: false)
                              
                    let logo = UIImage(named: "johonor2.png")
                    a = prt_sdk.print_image(in_image: logo , align: 1, nDPI: 180)
                    a = prt_sdk.set_font_size(width: 0, height: 0)

                    let roomNumber : String = self.reservations[0].roomNumber as! String
                    let myPasscode = self.reservations[0].roomNumber
                              
                    a = prt_sdk.print_string(str:"\n\n\nWelcome!\n\nCheckin: 4PM\nCheckout: 10AM\nWifi passcode: 77777777\nYou can use the luggage room from now on.\nLuggage room passcode: 1234*\n\nWhen you checkout, there's nothing to do but\nPlease put all your trashes to the basket in the\nluggage room.\n\nLate checkout = 5000won/hour\nLaundry + dry = 10000won\n\n\nCheckin ~ Checkout        Rooms       Passcode\n================================================\( self.reservations[0].checkInDate ?? "")~\( self.reservations[0].checkOutDate ?? "")   \(roomNumber)         \(myPasscode ?? "n/a") \n\n\n\nMobile1: +821026775000\nMobile2: +821077243715\nKakao: jhonor\nWechat: jhonor\nLine: jhonor\n\n" as NSString, align: 0)
                                        
                                         //add feed
                   a = prt_sdk.print_line_feed(nLine: 3)
                       
                                         //add partial cut
                   a = prt_sdk.print_cut(partial_cut: true)
                                 
                                         //let sendBuf = prt_sdk.get_sendBuffer_nsdata()
                                         
                   let nSendByte = prt_sdk.send_print_data(nTimeout: 10)
                                         
                                         if(nSendByte < 1) {
                                             print("[ERROR] add to string print buffer")
                                        if(a < 0 ) {
                                              print("error")
                                          }
                                         }
                                     }

                              
            }
        } else {
              Text("Your reservation code is wrong")
        }
    }
    
}

