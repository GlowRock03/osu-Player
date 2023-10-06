//
//  PlaylistView.swift
//  osu!Player
//
//  Created by Thomas on 2023-09-07.
//

import SwiftUI

struct PlaylistView: View {
    @ObservedObject var pageNav: AppViewModel

    var body: some View {
        Text("playlist view")
        Text("still gotta make it oof")
        Button(action: {
            pageNav.togglePlaylistMenu()
            pageNav.toggleMainMenu()
        }) {
            Text("Back to main page")
        }
    }
}


struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(pageNav: AppViewModel())
    }
}

