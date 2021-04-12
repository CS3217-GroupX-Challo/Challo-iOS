//
//  CustomSlider.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI
import Combine

// Adapted from https://stackoverflow.com/questions/62587261/swiftui-2-handle-range-slider
class CustomSlider: ObservableObject {
    
    // Slider Size
    final let lineWidth: CGFloat = 8
    final let width: CGFloat
    
    // Slider value range from valueStart to valueEnd
    final let valueStart: Double
    final let valueEnd: Double
    
    // Slider Handle
    @Published var highHandle: SliderHandle
    @Published var lowHandle: SliderHandle
    
    // Handle start percentage (also for starting point)
    @SliderValue var highHandleStartPercentage = 1.0
    @SliderValue var lowHandleStartPercentage = 0.0

    final var anyCancellableHigh: AnyCancellable?
    final var anyCancellableLow: AnyCancellable?
    
    init(width: CGFloat, start: Double, end: Double) {
        self.width = width
        valueStart = start
        valueEnd = end
        
        highHandle = SliderHandle(sliderWidth: width,
                                  sliderHeight: lineWidth,
                                  sliderValueStart: valueStart,
                                  sliderValueEnd: valueEnd,
                                  startPercentage: _highHandleStartPercentage,
                                  isLowerHandle: false)
        
        lowHandle = SliderHandle(sliderWidth: width,
                                 sliderHeight: lineWidth,
                                 sliderValueStart: valueStart,
                                 sliderValueEnd: valueEnd,
                                 startPercentage: _lowHandleStartPercentage,
                                 isLowerHandle: true)
                
        highHandle.otherHandleLocation = lowHandle.currentLocation
        lowHandle.otherHandleLocation = highHandle.currentLocation
        
        anyCancellableHigh = highHandle.objectWillChange.sink { [weak self] _ in
            self?.lowHandle.otherHandleLocation = self?.highHandle.currentLocation
            self?.objectWillChange.send()
        }
        anyCancellableLow = lowHandle.objectWillChange.sink { [weak self] _ in
            self?.highHandle.otherHandleLocation = self?.lowHandle.currentLocation
            self?.objectWillChange.send()
        }
    }
    
    // Percentages between high and low handle
    var percentagesBetween: String {
        String(format: "%.2f", highHandle.currentPercentage.wrappedValue - lowHandle.currentPercentage.wrappedValue)
    }
    
    // Value between high and low handle
    var valueBetween: String {
        String(format: "%.2f", highHandle.currentValue - lowHandle.currentValue)
    }
}
