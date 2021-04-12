//
//  RectangleCheckBox.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct RectangleCheckBox: View {
    @State var length: CGFloat
    @Binding var isChecked: Bool

    @State var trimValue: CGFloat = 0
    
    var animatableData: CGFloat {
        get { trimValue }
        set { trimValue = newValue }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .trim(from: 0, to: trimValue)
                .stroke(lineWidth: 2)
                .frame(width: length, height: length)
                .foregroundColor(isChecked ? Color.green : Color.gray.opacity(0.2))
            RoundedRectangle(cornerRadius: 10)
                .fill(isChecked ? Color.green : Color.gray.opacity(0.2))
                .frame(width: length - 10, height: length - 10)
            if isChecked {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.white)
            }
        }.onTapGesture {
            if !isChecked {
                withAnimation(Animation.easeIn(duration: 0.8)) {
                    trimValue = 1
                    isChecked.toggle()
                }
            } else {
                withAnimation(Animation.easeIn(duration: 0.8)) {
                    trimValue = 0
                    isChecked.toggle()
                }
            }
        }
    }
}

struct RectangleCheckBox_Previews: PreviewProvider {
    @State static var isChecked = false

    static var previews: some View {
        RectangleCheckBox(length: 50, isChecked: $isChecked)
    }
}
