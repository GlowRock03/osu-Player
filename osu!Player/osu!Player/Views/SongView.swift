//
//  SongView.swift
//  osu!Player
//
//  Created by Thomas on 2023-09-07.
//

import SwiftUI

struct SongView: View {
    @ObservedObject var pageNav: AppViewModel

    var body: some View {
        Text("song view")
        Text("still gotta make it oof")
        Button(action: {
            pageNav.toggleSongMenu()
            pageNav.toggleMainMenu()
        }) {
            Text("Back to main page")
        }
    }
}

/*
struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView()
    }
}
*/
