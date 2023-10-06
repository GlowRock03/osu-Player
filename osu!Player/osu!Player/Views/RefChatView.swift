//
//  RefChatView.swift
//  osu!Player
//
//  Created by Thomas on 2023-09-07.
//

import SwiftUI

struct RefChatView: View {
    @ObservedObject var pageNav: AppViewModel

    var body: some View {
        Text("ref chat view")
        Text("still gotta make it oof")
        Button(action: {
            pageNav.toggleRefChatMenu()
            pageNav.toggleMainMenu()
        }) {
            Text("Back to main page")
        }
    }
}


struct RefChatView_Previews: PreviewProvider {
    static var previews: some View {
        RefChatView(pageNav: AppViewModel())
    }
}
