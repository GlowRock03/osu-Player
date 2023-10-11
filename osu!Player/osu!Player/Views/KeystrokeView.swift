//
//  KeystrokeView.swift
//  osu!Player
//
//  Created by Thomas on 2023-08-07.
//

import Foundation
import SwiftUI

let rectangleAmount = 60

struct KeystrokeView: View {
    
    private struct RectangleState {
        var height: CGFloat
        var offset: CGFloat
        var heldTime: Double
        var stopTime: Double
        var growthTimer: Timer?
        var offsetTimer: Timer?
        init() {
            height = 0.0
            offset = 0.0
            heldTime = 0.0
            stopTime = 0.0
        }
    }
    
    @ObservedObject var pageNav: AppViewModel
    
    @State private var zTap = false
    @State private var zTapGate = false
    @State private var zBarIndex = 0
    @State private var zBars = [RectangleState](repeating: RectangleState(), count: rectangleAmount)       //count may need to scaled for screen size, note this is also in ForEach{}
    
    @State private var xTap = false
    @State private var xTapGate = false
    @State private var xBarIndex = 0
    @State private var xBars = [RectangleState](repeating: RectangleState(), count: rectangleAmount)       //count may need to scaled for screen size, note this is also in ForEach{}

    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()       //change to bg image
            VStack {
                Spacer()
                Spacer()
                Spacer()
            
                HStack(spacing: 20) {
                    VStack {            //z button stack
                        Group {
                            ZStack {
                                ForEach(0...rectangleAmount - 1, id: \.self) { i in
                                    Rectangle()                                 //stroke bar
                                        .frame(width: 80, height: zBars[i].height)
                                        .foregroundColor(Color.green)
                                        .offset(y: zBars[i].offset - (zBars[i].height / 2) - 115)
                                        .scaleEffect(CGSize(width: 1.0, height: -1.0), anchor: .topLeading)
                                }
                            }
                        }
                        .frame(height: 200)
                        Group {
                            Rectangle()                                     //z button
                                .foregroundColor(zTap ? .green : .mint)
                                .border(.black, width: 5)
                                .overlay {
                                    Text("z")
                                        .font(.system(size: 36))
                                        .font(.system(.headline))
                                }
                                .frame(width: 80, height: 90)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                    .onChanged( { _ in
                                        if !zTap {                  //logic here to only start the animation on the intial press
                                            zTap = true             //ensures when dragged that the animation doesn't start again
                                            zTapGate = true
                                        }
                                        else {
                                            zTapGate = false
                                        }
                                        
                                        if zTap && zTapGate {      //start animation
                                            let intervalIndex = zBarIndex
                                            zGrowBar(index: intervalIndex)
                                        }
                                    })
                                    .onEnded( { _ in
                                        let finishIndex = zBarIndex
                                        zOffsetBar(index: finishIndex)
                                        if zBarIndex == zBars.count - 1 {
                                            zBarIndex = 0
                                        }
                                        else {
                                            zBarIndex = zBarIndex + 1
                                        }
                                        zTap = false
                                        zTapGate = false
                                    })
                                )
                        }
                    }
                    VStack {        //x button stack
                        Group {
                            ZStack {
                                ForEach(0...rectangleAmount - 1, id: \.self) { i in
                                    Rectangle()                                 //stroke bar
                                        .frame(width: 80, height: xBars[i].height)
                                        .foregroundColor(Color.green)
                                        .offset(y: xBars[i].offset - (xBars[i].height / 2) - 115)
                                        .scaleEffect(CGSize(width: 1.0, height: -1.0), anchor: .topLeading)
                                }
                            }
                        }
                        .frame(height: 200)
                        Group {
                            Rectangle()                                     //z button
                                .foregroundColor(xTap ? .green : .mint)
                                .border(.black, width: 5)
                                .overlay {
                                    Text("x")
                                        .font(.system(size: 36))
                                        .font(.system(.headline))
                                }
                                .frame(width: 80, height: 90)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                    .onChanged( { _ in
                                        if !xTap {                  //logic here to only start the animation on the intial press
                                            xTap = true             //ensures when dragged that the animation doesn't start again
                                            xTapGate = true
                                        }
                                        else {
                                            xTapGate = false
                                        }
                                        
                                        if xTap && xTapGate {      //start animation
                                            let intervalIndex = xBarIndex
                                            xGrowBar(index: intervalIndex)
                                        }
                                    })
                                    .onEnded( { _ in
                                        let finishIndex = xBarIndex
                                        xOffsetBar(index: finishIndex)
                                        if xBarIndex == xBars.count - 1 {
                                            xBarIndex = 0
                                        }
                                        else {
                                            xBarIndex = xBarIndex + 1
                                        }
                                        xTap = false
                                        xTapGate = false
                                    })
                                )
                        }
                    }
                }
                Spacer()
            }
        }
        Button(action: {
            pageNav.toggleKeystokeMenu()
            pageNav.toggleMainMenu()
        }) {
            Text("Back to main page")
        }
    }
    
    private func zGrowBar(index: Int) {
        zBars[index].growthTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if zTap {
                zBars[index].heldTime += 0.01
                zBars[index].height += 3
            }
            else {
                zBars[index].growthTimer?.invalidate()
                zBars[index].growthTimer = nil
            }
        }
    }
    
    private func zOffsetBar(index: Int) {
        zBars[index].offsetTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if (zBars[index].stopTime <= 2.0) {
                zBars[index].offset += 3
                zBars[index].stopTime += 0.01
            }
            else {
                zBars[index].offsetTimer?.invalidate()
                zBars[index].offsetTimer = nil
                zBars[index].stopTime = 0
                zBars[index].offset = 0
                zBars[index].height = 0.0
                zBars[index].heldTime = 0
            }
        }
    }
    
    private func xGrowBar(index: Int) {
        xBars[index].growthTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if xTap {
                xBars[index].heldTime += 0.01
                xBars[index].height += 3
            }
            else {
                xBars[index].growthTimer?.invalidate()
                xBars[index].growthTimer = nil
            }
        }
    }
    
    private func xOffsetBar(index: Int) {
        xBars[index].offsetTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if (xBars[index].stopTime <= 2.0) {
                xBars[index].offset += 3
                xBars[index].stopTime += 0.01
            }
            else {
                xBars[index].offsetTimer?.invalidate()
                xBars[index].offsetTimer = nil
                xBars[index].stopTime = 0
                xBars[index].offset = 0
                xBars[index].height = 0.0
                xBars[index].heldTime = 0
            }
        }
    }
    
    private func getNextIntervalEndTime(heldTime: Double) -> Double {
        var nextTime = Int(heldTime)
        if nextTime % 4 == 0 {
            nextTime += 4
        }
        else if nextTime % 3 == 0 {
            nextTime += 1
        }
        else if nextTime % 2 == 0 {
            nextTime += 2
        }
        else {
            nextTime += 3
        }
        return Double(nextTime)
    }
}

struct KeystrokeView_Preview: PreviewProvider {
    static var previews: some View {
        KeystrokeView(pageNav: AppViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
