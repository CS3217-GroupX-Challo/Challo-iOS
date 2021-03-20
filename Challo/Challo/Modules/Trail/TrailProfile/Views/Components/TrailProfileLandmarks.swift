//
//  TrailProfileLandmarks.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileLandmarks: View {
    let trail: Trail
    
    var landmarks: [String] {
        trail.landmarks
    }

    func makeLandmark(_ index: Int) -> AnyView? {
        guard index < landmarks.count else {
            return nil
        }
        return AnyView(HStack {
            Text("\(index)").padding()
                .overlay(
                    Circle().stroke(Color.themeTertiary, lineWidth: 1.5)
                        .padding(6)
                  )
            VStack(alignment: .leading) {
                if index == 0 {
                    Text("Meeting Point:").bold()
                } else if index == landmarks.count - 1 {
                    Text("End Point:").bold()
                }
                Text(landmarks[index])
            }.font(.callout)
        })
    }
    
    var body: some View {
        ForEach(landmarks.indices, content: makeLandmark)
    }
}
