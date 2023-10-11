//
//  osu_PlayerApp.swift
//  osu!Player
//
//  Created by Thomas on 2023-07-01.
//

import SwiftUI

@main
struct osu_PlayerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
            //KeystrokeView(pageNav: AppViewModel())      //testing only,     REMOVE LATER
        }
    }                               //View
}
