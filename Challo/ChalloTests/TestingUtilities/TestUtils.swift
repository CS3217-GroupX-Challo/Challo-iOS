//
//  TestUtils.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 4/4/21.
//

struct TestUtils {

    /// Compare if the elements in two given arrays are equal, disregarding ordering
    static func compareTwoArrays<T: Equatable>(first: [T], second: [T]) -> Bool {
        for e in first {
            if !second.contains(e) {
                return false
            }
        }
        
        for e in second {
            if !first.contains(e) {
                return false
            }
        }
        
        return true
    }
}
