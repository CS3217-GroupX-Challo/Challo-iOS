//
//  TrailProfileLandmarks.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileLandmarks: View {
    let landmarks: [String]
    
    @ViewBuilder
    func makeLandmark(_ index: Int) -> some View {
        let landmark = landmarks[index]
        HStack {
            Text("\(index)").padding()
                .overlay(
                    Circle().stroke(Color.themePrimary, lineWidth: 1.5)
                        .padding(6)
                  )
            VStack(alignment: .leading) {
                if index == 0 {
                    Text("Meeting Point:").bold()
                } else if index == landmarks.count - 1 {
                    Text("End Point:").bold()
                }
                Text(landmark)
            }.font(.callout)
        }
    }
    
    var body: some View {
        ForEach(landmarks.indices, content: makeLandmark)
    }
}
