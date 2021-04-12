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
    final let width: CGFloat = 300
    final let lineWidth: CGFloat = 8
    
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
    
    init(start: Double, end: Double) {
        valueStart = start
        valueEnd = end
        
        highHandle = SliderHandle(sliderWidth: width,
                                  sliderHeight: lineWidth,
                                  sliderValueStart: valueStart,
                                  sliderValueEnd: valueEnd,
                                  startPercentage: _highHandleStartPercentage
                                )
        
        lowHandle = SliderHandle(sliderWidth: width,
                                 sliderHeight: lineWidth,
                                 sliderValueStart: valueStart,
                                 sliderValueEnd: valueEnd,
                                 startPercentage: _lowHandleStartPercentage)
        
        anyCancellableHigh = highHandle.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        anyCancellableLow = lowHandle.objectWillChange.sink { _ in
            self.objectWillChange.send()
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
