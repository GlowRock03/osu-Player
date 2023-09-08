//
//  MainUI.swift
//  osu!Player
//
//  Created by Thomas on 2023-07-01.
//

import SwiftUI
import AVKit



class SongInfo: ObservableObject {
    @Published var songName: String = "Triangles"
    @Published var artistName: String = "cYsmix"
    @Published var audioPlayer: AVAudioPlayer!
    @Published var currentSongTime: Double = 0.0
    @Published var totalSongTime: Double = 0.0
    @Published var timer: Timer?
    @Published var playingBol = true
}

class AppViewModel: ObservableObject {
    @Published var showMainPage = true
    @Published var showSongPage = false
    @Published var showPlaylistPage = false
    @Published var showKeystrokePage = false
    @Published var showSettingsPage = false
    @Published var showChatPage = false
    @Published var showRefChatPage = false
    
    func toggleMainMenu() {
        if showMainPage {
            showMainPage = false
        } else {
            showMainPage = true
        }
    }
    func toggleSongMenu() {
        if showSongPage {
            showSongPage = false
        } else {
            showSongPage = true
        }
    }
    func togglePlaylistMenu() {
        if showPlaylistPage {
            showPlaylistPage = false
        } else {
            showPlaylistPage = true
        }
    }
    func toggleKeystokeMenu() {
        if showKeystrokePage {
            showKeystrokePage = false
        } else {
            showKeystrokePage = true
        }
    }
    func toggleSettingsMenu() {
        if showSettingsPage {
            showSettingsPage = false
        } else {
            showSettingsPage = true
        }
    }
    func toggleChatMenu() {
        if showChatPage {
            showChatPage = false
        } else {
            showChatPage = true
        }
    }
    func toggleRefChatMenu() {
        if showRefChatPage {
            showRefChatPage = false
        } else {
            showRefChatPage = true
        }
    }
    
}

//let pageNum = 0

struct MainView: View {
    
    @StateObject private var songInformation = SongInfo()
    
    @StateObject private var showMenu = AppViewModel()
    // 0 -> MainMenu, 1 -> SongMenu, 2 -> PlaylistMenu, 3 -> KeystokeMenu, 4 -> SettingsMenu
    //let pageNum = 0
    
    var body: some View {
        Group {
            if showMenu.showMainPage {
                MainMenuView(pageNav: showMenu, songInfo: songInformation)
            }
            if showMenu.showSongPage {
                SongView(pageNav: showMenu)
            }
            if showMenu.showPlaylistPage {
                PlaylistView(pageNav: showMenu)
            }
            if showMenu.showKeystrokePage {
                KeystrokeView(pageNav: showMenu)
            }
            if showMenu.showSettingsPage {
                SettingsView(pageNav: showMenu)
            }
            if showMenu.showChatPage {
                ChatView(pageNav: showMenu)
            }
            if showMenu.showRefChatPage {
                RefChatView(pageNav: showMenu)
            }
        }
        .onAppear {
            let soundURL = Bundle.main.url(forResource: "triangles", withExtension: "mp3")
            do {
                try songInformation.audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
                    songInformation.audioPlayer.prepareToPlay()
                    songInformation.audioPlayer.isMeteringEnabled = true
                }
            catch {
                print(error)
            }
                    
            songInformation.audioPlayer?.play()
            songInformation.totalSongTime = songInformation.audioPlayer?.duration ?? 0.0
            
            songInformation.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
                guard let audioPlayer = songInformation.audioPlayer else {
                    songInformation.timer?.invalidate()
                    return
                }
                songInformation.currentSongTime = audioPlayer.currentTime
            }
        }                           //onAppear
    }
    
}                                   //Struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
        }
    }
}
