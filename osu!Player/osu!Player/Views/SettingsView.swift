//
//  SettingsView.swift
//  osu!Player
//
//  Created by Thomas on 2023-09-07.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var pageNav: AppViewModel

    var body: some View {
        Text("settings view")
        Text("still gotta make it oof")
        Button(action: {
            pageNav.toggleSettingsMenu()
            pageNav.toggleMainMenu()
        }) {
            Text("Back to main page")
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(pageNav: AppViewModel())
    }
}

