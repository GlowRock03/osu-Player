//
//  MainMenuView.swift
//  osu!Player
//
//  Created by Thomas on 2023-09-06.
//

import SwiftUI
import AVKit
import MarqueeText

struct MainMenuView: View {
    
    @ObservedObject var pageNav: AppViewModel
    @ObservedObject var songInfo: SongInfo
    

    
    @State var scrollText = false
    @State var logoClicked = false
    @State var underButton = false
    @State var loopState = 0
    @State var songSpeedBol = false
    
    
    

    
    @State var meterLevels: [Float] = Array(repeating: 1.0, count: 8)
    
    private let numberOfRectangles = 8
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                Image("default-bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
                Image("black-base")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: 175)
                    .offset(y: geometry.size.height - 175)
                    .edgesIgnoringSafeArea(.bottom)
                Image("black-base")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: 120)
                    .edgesIgnoringSafeArea(.top)
            }   // Group
            VStack {    // VStack for all components
            
                VStack {
                    HStack(alignment: .center) {
                        Image("song-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        MarqueeText(
                            text: songInfo.songName,
                            font: UIFont.preferredFont(forTextStyle: .headline),
                            leftFade: 16,
                            rightFade: 16,
                            startDelay: 3)
                        .foregroundColor(.white)
                    }
                    HStack(alignment: .center) {
                        Image("artist-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        MarqueeText(
                            text: songInfo.artistName,
                            font: UIFont.preferredFont(forTextStyle: .headline),
                            leftFade: 16,
                            rightFade: 16,
                            startDelay: 3)
                        .foregroundColor(.white)
                    }
                }
                .padding(.top, 5)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                Spacer()
                Spacer()
                Spacer()
                ZStack {
                    VStack {
                        HStack(alignment: .center) {
                            Button(action: {
                                pageNav.toggleMainMenu()
                                pageNav.toggleChatMenu()
                            }) {
                                Image("chat-button")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 50)
                            }
                            Spacer()
                            Spacer()
                            Spacer()
                            Button(action: {
                                pageNav.toggleMainMenu()
                                pageNav.toggleRefChatMenu()
                            }) {
                                Image("ref-chat-button")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 50)
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        HStack(alignment: .center) {
                            Image("song-speed-button")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: songSpeedBol ? 60 : 50, height: songSpeedBol ? 60 : 50)
                                .rotationEffect(.degrees(songSpeedBol ? 10 : 0))
                                .onTapGesture() {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        songSpeedBol.toggle()
                                        //call to backend
                                        
                                        
                                        
                                    }
                                }
                            Spacer()
                            Spacer()
                            Spacer()
                            Button(action: {
                                //open help menu
                                //call to backend
                                
                                
                                
                                
                                
                            }) {
                                Image("help-button")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .frame(height: 50)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        Spacer()
                    }
                    ZStack(alignment: .center) {
                        CircularAudioVisualizer(audioLevels: meterLevels)
                            .frame(width: 270, height: 270)
                            .scaleEffect(0.96)
                            .offset(x: logoClicked ? 89 : 129, y: 120)
                        VStack(alignment: .center) {
                            
                            Image("song-button")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 50)
                                .onTapGesture {
                                    pageNav.toggleMainMenu()
                                    pageNav.toggleSongMenu()
                                }
                                .offset(x: underButton ? 98 : 0)
                            Image("playlist-button")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 50)
                                .onTapGesture {
                                    pageNav.toggleMainMenu()
                                    pageNav.togglePlaylistMenu()
                                }
                                .offset(x: underButton ? 110 : 0)
                            Image("settings-button")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 50)
                                .onTapGesture {
                                    pageNav.toggleMainMenu()
                                    pageNav.toggleSettingsMenu()
                                }
                                .offset(x: underButton ? 110 : 0)
                            Image("tap-button")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 50)
                                .onTapGesture {
                                    pageNav.toggleMainMenu()
                                    pageNav.toggleKeystokeMenu()
                                }
                                .offset(x: underButton ? 98 : 0)
                        }
                        Image("osu-logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:270, height:270)
                            .contentShape(Circle())
                            .onTapGesture {
                                withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0)) {
                                    logoClicked.toggle()
                                }
                                withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0)) {
                                    underButton.toggle()
                                }
                            }
                            .offset(x: logoClicked ? -40 : 0)
                    }
                    .offset(y: -15)
                    
                }
                
                Spacer()
                Spacer()
                //Spacer()
                HStack(alignment: .center) {
                    Text("\(formatTime(songInfo.currentSongTime))")
                        .foregroundColor(.white)
                        .font(.headline)
                        .lineLimit(1)
                    Slider(value: $songInfo.currentSongTime, in: 0...songInfo.totalSongTime, onEditingChanged: { editing in
                        if !editing, let player = songInfo.audioPlayer {
                            if songInfo.playingBol {
                                player.pause()
                                songInfo.playingBol = false
                                player.currentTime = songInfo.currentSongTime
                                player.play()
                                songInfo.playingBol = true
                            }
                            else {
                                player.currentTime = songInfo.currentSongTime
                            }
                        }
                    })
                    .disabled(songInfo.totalSongTime == 0)
                        .frame(width: geometry.size.width * 0.7)
                    Text("\(formatTime(songInfo.totalSongTime))")
                        .foregroundColor(.white)
                        .font(.headline)
                        .lineLimit(1)
                }
                //.offset(x: -8)
                
                Text("")
                    .frame(height: 7)
            
                HStack(alignment: .center) {            //song buttons
                        ZStack {        //song nav buttons (ZStack toogle)
                            if loopState == 0 {
                                Button(action: {
                                    //call to backend
                                    loopState = 1
                                    
                                    
                                    
                                    
                                }) {
                                    Image("song-loop-all")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .aspectRatio(contentMode: .fit)
                                }
                            } else if loopState == 1 {
                                Button(action: {
                                    //call to backend
                                    loopState = 2
                                    
                                    
                                    
                                    
                                }) {
                                    Image("song-loop-random")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .aspectRatio(contentMode: .fit)
                                }
                            } else {
                                Button(action: {
                                    //call to backend
                                    loopState = 0
                                    
                                    
                                    
                                    
                                }) {
                                    Image("song-single-loop")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }   //Song nav
                        Text("")                            //Spacer
                            .frame(width: 40, height: 40)
                        Button(action: {
                            //self.audioPlayer.previous()
                            //call to backend
                            
                            
                            
                            
                        }) {
                            Image("previous")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .aspectRatio(contentMode: .fit)
                        }
                        ZStack {                            // play/pause
                            if songInfo.playingBol {
                                Button(action: {
                                    songInfo.audioPlayer.pause()
                                    songInfo.playingBol = false
                                    //call to backend
                                    
                                    
                                    
                                    
                                }) {
                                    Image("pause")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .aspectRatio(contentMode: .fit)
                                }
                            } else {
                                Button(action: {
                                    songInfo.audioPlayer.play()
                                    songInfo.playingBol = true
                                    //call to backend
                                    
                                    
                                    
                                    
                                }) {
                                    Image("play")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }                               //next/last
                        Button(action: {
                            //self.audioPlayer.next()
                            //call to backend
                            
                            
                            
                            
                        }) {
                            Image("next")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        Text("")
                            .frame(width: 40, height: 40)
                        Button(action: {
                            //call to backend
                            
                            
                            
                            
                            
                        }) {
                            Image("upload")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .aspectRatio(contentMode: .fit)
                        }
                    }               //HStack Song buttons
                    .padding(.bottom, 25)
            }                       //VStack
            //.padding(.leading, 13)
        }                           //Geometry Reader
        .onAppear {
            
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                songInfo.audioPlayer?.updateMeters()
                
                let avgPower = songInfo.audioPlayer?.averagePower(forChannel: 0) ?? -160
                let level = 19 * pow(10, avgPower / 20) + 1
                meterLevels = getLevels(powLevel: level)
            }
            
            songInfo.totalSongTime = songInfo.audioPlayer?.duration ?? 0.0
            
            songInfo.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
                guard let audioPlayer = songInfo.audioPlayer else {
                    songInfo.timer?.invalidate()
                    return
                }
                songInfo.currentSongTime = audioPlayer.currentTime
            }
        }
        .onDisappear {
            songInfo.timer?.invalidate()
        }
        
        
        
    }                               //View
    
    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    func getLevels(powLevel: Float) -> [Float] {
        
        var powerLevels: [Float] = []
        
        let rangeBot: Float = 1.5
        let rangeTop: Float = 2.0
        var currDiff: Float = 0.0
        
        for _ in 0..<4 {
            let tempRandom: Float = Float.random(in: (rangeBot - currDiff)...(rangeTop - currDiff))
            if powLevel - tempRandom < 1 || (0.99 < powLevel && powLevel < 1.2) {
                powerLevels.append(1.0)
            }
            else {
                powerLevels.append(powLevel - tempRandom)
            }
            currDiff = currDiff + 0.5
        }
        powerLevels.append(powLevel)
        currDiff = 0.0
        for _ in 5..<8 {
            let tempRandom: Float = Float.random(in: (rangeBot + currDiff)...(rangeTop + currDiff))
            if powLevel + tempRandom > 20.0 {
                powerLevels.append(20.0)
            }
            else if (0.99 < powLevel && powLevel < 1.2) {
                powerLevels.append(1.0)
            }
            else {
                powerLevels.append(powLevel + tempRandom)
            }
            currDiff = currDiff + 0.1
        }
        return powerLevels
    }
}

struct Bar: View {

    var height: CGFloat
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let width: CGFloat

    var body: some View {
       ZStack {
           RoundedRectangle(cornerSize: CGSize(width: 1, height: 1))
               .frame(width: width, height: height)
               .animation(.easeInOut(duration: 0.3), value: height)
               .foregroundColor(Color.mint)
       }
       .frame(height: maxHeight, alignment: .top)
    }
}

struct CircularAudioVisualizer: View {
    
    var audioLevels: [Float]
    
    var body: some View {
        GeometryReader { geometry in
            
            ForEach(0..<360) { i in
                let someHeight: CGFloat = CGFloat(audioLevels[i % 8])
                Bar(height: someHeight, maxHeight: 20, minHeight: 1, width: 1)
                   .offset(y: 150)
                   .rotationEffect(.degrees(1 * Double(i)))
            }
            
        }
    }
}


struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(pageNav: AppViewModel(), songInfo: SongInfo())
    }
}

