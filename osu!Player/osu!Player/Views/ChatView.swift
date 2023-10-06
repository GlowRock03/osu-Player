//
//  ChatView.swift
//  osu!Player
//
//  Created by Thomas on 2023-09-07.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var pageNav: AppViewModel

    var body: some View {
        Text("chat view")
        Text("still gotta make it oof")
        Button(action: {
            pageNav.toggleChatMenu()
            pageNav.toggleMainMenu()
        }) {
            Text("Back to main page")
        }
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(pageNav: AppViewModel())
    }
}

