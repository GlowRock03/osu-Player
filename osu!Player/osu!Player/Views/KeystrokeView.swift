//
//  KeystrokeView.swift
//  osu!Player
//
//  Created by Thomas on 2023-08-07.
//

import Foundation
import SwiftUI

let rectangleAmount = 100

struct KeystrokeView: View {
    
    private struct RectangleState {
        var height: CGFloat
        var offset: CGFloat
        var heldTime: Double
        var stopTime: Double
        var growthTimer: Timer?
        var endStrokeTimer: Timer?
        init() {
            height = 0.0
            offset = 0.0
            heldTime = 0.0
            stopTime = 0.0
        }
    }
    
    @ObservedObject var pageNav: AppViewModel
    
    @State private var zTap = false
    @State private var zTapLogic = false
    @State private var zBarIndex = 0
    @State private var zRectangleArray = [RectangleState](repeating: RectangleState(), count: rectangleAmount)       //count may need to scaled for screen size, note this is also in ForEach{}
    
    @State private var xTap = false
    @State private var xTapLogic = false
    @State private var xBarIndex = 0
    @State private var xRectangleArray = [RectangleState](repeating: RectangleState(), count: rectangleAmount)       //count may need to scaled for screen size, note this is also in ForEach{}

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
                                        .frame(width: 80, height: zRectangleArray[i].height)
                                        .foregroundColor(Color.green)
                                        .offset(y: zRectangleArray[i].offset - (zRectangleArray[i].height / 2) - 115)
                                        .scaleEffect(CGSize(width: 1.0, height: -1.0), anchor: .bottomLeading)
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
                                            zTapLogic = true
                                        }
                                        else {
                                            zTapLogic = false
                                        }
                                        
                                        if zTap && zTapLogic {      //start animation
                                            let intervalIndex = zBarIndex
                                            zGrowStroke(index: intervalIndex)
                                        }
                                    })
                                    .onEnded( { _ in
                                        let stopTime: DispatchTime = .now()
                                        let finishIndex = zBarIndex
                                        let roundedTime = round(zRectangleArray[finishIndex].heldTime * 100) / 100.0
                                        let diff = getNextIntervalEndTime(heldTime: roundedTime) - roundedTime
                                        zEndTimer(letGo: stopTime, timeDiff: diff, index: finishIndex)
                                        if zBarIndex == zRectangleArray.count - 1 {
                                            zBarIndex = 0
                                        }
                                        else {
                                            zBarIndex = zBarIndex + 1
                                        }
                                        zTap = false
                                        zTapLogic = false
                                    })
                                )
                        }
                    }
                    VStack {        //x button stack
                        Group {
                            ZStack {
                                ForEach(0...rectangleAmount - 1, id: \.self) { i in
                                    Rectangle()                                 //stroke bar
                                        .frame(width: 80, height: xRectangleArray[i].height)
                                        .foregroundColor(Color.green)
                                        .offset(y: xRectangleArray[i].offset - (xRectangleArray[i].height / 2) - 115)
                                        .scaleEffect(CGSize(width: 1.0, height: -1.0), anchor: .bottomLeading)
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
                                            xTapLogic = true
                                        }
                                        else {
                                            xTapLogic = false
                                        }
                                        
                                        if xTap && xTapLogic {      //start animation
                                            let intervalIndex = xBarIndex
                                            xGrowStroke(index: intervalIndex)
                                        }
                                    })
                                    .onEnded( { _ in
                                        let stopTime: DispatchTime = .now()
                                        let finishIndex = xBarIndex
                                        let roundedTime = round(xRectangleArray[finishIndex].heldTime * 100) / 100.0
                                        let diff = getNextIntervalEndTime(heldTime: roundedTime) - roundedTime
                                        xEndTimer(letGo: stopTime, timeDiff: diff, index: finishIndex)
                                        if xBarIndex == xRectangleArray.count - 1 {
                                            xBarIndex = 0
                                        }
                                        else {
                                            xBarIndex = xBarIndex + 1
                                        }
                                        xTap = false
                                        xTapLogic = false
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
    
    private func zGrowStroke(index: Int) {
        zRectangleArray[index].growthTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if zTap {
                let roundedTimer = round(zRectangleArray[index].heldTime * 100) / 100.0
                if roundedTimer.truncatingRemainder(dividingBy: 4) == 0 {
                    zStartStroke(intervalTime: Int(roundedTimer), index: index)
                }
                zRectangleArray[index].heldTime += 0.01
                zRectangleArray[index].height += 3
                zRectangleArray[index].offset += 3
            }
            else {
                zRectangleArray[index].growthTimer?.invalidate()
                zRectangleArray[index].growthTimer = nil
            }
        }
    }
    
    private func zEndTimer(letGo: DispatchTime, timeDiff: Double, index: Int) {
        if !(zRectangleArray[index].height >= 500) {
            DispatchQueue.main.asyncAfter(deadline: letGo + 2) {
                zRectangleArray[index].endStrokeTimer?.invalidate()
                zRectangleArray[index].endStrokeTimer = nil
                zRectangleArray[index].stopTime = 0
                zRectangleArray[index].offset = 0
                zRectangleArray[index].height = 0.0
                zRectangleArray[index].heldTime = 0
            }
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: letGo + (timeDiff - 0.08)) {
                zRectangleArray[index].endStrokeTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    if zRectangleArray[index].stopTime <= 2 {
                        zRectangleArray[index].stopTime += 0.01
                        zRectangleArray[index].offset += 3
                    }
                    else {
                        zRectangleArray[index].endStrokeTimer?.invalidate()
                        zRectangleArray[index].endStrokeTimer = nil
                        zRectangleArray[index].stopTime = 0
                        zRectangleArray[index].offset = 0
                        zRectangleArray[index].height = 0.0
                        zRectangleArray[index].heldTime = 0
                    }
                }
            }
        }
    }
    
    private func zStartStroke(intervalTime: Int, index: Int) {
        withAnimation(.linear(duration: 4.0)) {
            zRectangleArray[index].offset += 1200
        }
    }
    
    private func xGrowStroke(index: Int) {
        xRectangleArray[index].growthTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if xTap {
                let roundedTimer = round(xRectangleArray[index].heldTime * 100) / 100.0
                if roundedTimer.truncatingRemainder(dividingBy: 4) == 0 {
                    xStartStroke(intervalTime: Int(roundedTimer), index: index)
                }
                xRectangleArray[index].heldTime += 0.01
                xRectangleArray[index].height += 3
                xRectangleArray[index].offset += 3
            }
            else {
                xRectangleArray[index].growthTimer?.invalidate()
                xRectangleArray[index].growthTimer = nil
            }
        }
    }
    
    private func xEndTimer(letGo: DispatchTime, timeDiff: Double, index: Int) {
        if !(xRectangleArray[index].height >= 500) {
            DispatchQueue.main.asyncAfter(deadline: letGo + 2) {
                xRectangleArray[index].endStrokeTimer?.invalidate()
                xRectangleArray[index].endStrokeTimer = nil
                xRectangleArray[index].stopTime = 0
                xRectangleArray[index].offset = 0
                xRectangleArray[index].height = 0.0
                xRectangleArray[index].heldTime = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: letGo + (timeDiff - 0.08)) {
            xRectangleArray[index].endStrokeTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                if xRectangleArray[index].stopTime <= 2 {
                    xRectangleArray[index].stopTime += 0.01
                    xRectangleArray[index].offset += 3
                }
                else {
                    xRectangleArray[index].endStrokeTimer?.invalidate()
                    xRectangleArray[index].endStrokeTimer = nil
                    xRectangleArray[index].stopTime = 0
                    xRectangleArray[index].offset = 0
                    xRectangleArray[index].height = 0.0
                    xRectangleArray[index].heldTime = 0
                }
            }
        }
    }
    
    private func xStartStroke(intervalTime: Int, index: Int) {
        withAnimation(.linear(duration: 4.0)) {
            xRectangleArray[index].offset += 1200
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
