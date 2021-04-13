//
//  SliderHandle.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

class SliderHandle: ObservableObject {
    
    // Slider Size
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    // Slider Range
    let sliderValueStart: Double
    let sliderValueRange: Double
    
    // Slider Handle
    var diameter: CGFloat = 25
    var startLocation: CGPoint
    
    // Current Value
    @Published var currentPercentage: SliderValue
    
    // Slider Button Location
    @Published var onDrag: Bool
    @Published var currentLocation: CGPoint
    
    let isLowerHandle: Bool
    var otherHandleLocation: CGPoint! 
        
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, sliderValueStart: Double, sliderValueEnd: Double,
         startPercentage: SliderValue, isLowerHandle: Bool) {
        self.sliderWidth = sliderWidth
        self.sliderHeight = sliderHeight
        
        self.sliderValueStart = sliderValueStart
        self.sliderValueRange = sliderValueEnd - sliderValueStart
        
        let startLocation = CGPoint(x: (CGFloat(startPercentage.wrappedValue) / 1.0) * sliderWidth, y: sliderHeight / 2)
        
        self.startLocation = startLocation
        self.currentLocation = startLocation
        self.currentPercentage = startPercentage
        
        self.onDrag = false
        self.isLowerHandle = isLowerHandle
    }
    
    lazy var sliderDragGesture: _EndedGesture<_ChangedGesture<DragGesture>> = DragGesture()
        .onChanged { value in
            self.onDrag = true
            
            let dragLocation = value.location
            
            // Restrict possible drag area
            self.restrictSliderBtnLocation(dragLocation)
            
            // Get current value
            self.currentPercentage.wrappedValue = Double(self.currentLocation.x / self.sliderWidth)
            
        }.onEnded { _ in
            self.onDrag = false
        }
    
    private func checkHandlersNotReversed(_ dragX: CGFloat) -> Bool {
        if isLowerHandle {
            return dragX < otherHandleLocation.x
        } else {
            return dragX > otherHandleLocation.x
        }
    }
    
    private func restrictSliderBtnLocation(_ dragLocation: CGPoint) {
        let dragX = dragLocation.x
        if dragX >= CGPoint.zero.x && dragX <= sliderWidth && checkHandlersNotReversed(dragX) {
            let xOffset = min(max(0, dragLocation.x), sliderWidth)
            calcSliderBtnLocation(CGPoint(x: xOffset, y: dragLocation.y))
        }
    }
    
    private func calcSliderBtnLocation(_ dragLocation: CGPoint) {
        if dragLocation.y != sliderHeight / 2 {
            currentLocation = CGPoint(x: dragLocation.x, y: sliderHeight / 2)
        } else {
            currentLocation = dragLocation
        }
    }
    
    // Current Value
    var currentValue: Double {
        sliderValueStart + currentPercentage.wrappedValue * sliderValueRange
    }
}
