//
//  KeystrokeView.swift
//  osu!Player
//
//  Created by Thomas on 2023-08-07.
//

import Foundation
import SwiftUI

struct KeystrokeView: View {
    
    @ObservedObject var pageNav: AppViewModel

    var body: some View {
        Text("keystoke view")
        Text("still gotta make it oof")
        Button(action: {
            pageNav.toggleKeystokeMenu()
            pageNav.toggleMainMenu()
        }) {
            Text("Back to main page")
        }
    }
}

/*
struct keystrokeView_Preview: PreviewProvider {
    static var previews: some View {
        KeystrokeView()
    }
}
 */



