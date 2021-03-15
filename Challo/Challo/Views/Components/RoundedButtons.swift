import SwiftUI

struct RoundedCornerButtonStyle: ButtonStyle {
 
    var color: Color
    var backgroundColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(backgroundColor)
            .padding(10)
            .overlay(
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(color, lineWidth: 1)
               )
        }
}
