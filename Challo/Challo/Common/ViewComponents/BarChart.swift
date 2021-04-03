//
//  BarChart.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

/// A bar chart that plots `data` against `axisLabels`, and prints the values on top of the bar.
/// `axisLabels` and `data` should be of the same length
struct BarChart: View {

    var axisLabels: [String]
    var data: [Double]

    var barWidth: CGFloat
    var barUnitHeight: Double
    var dataFormatSpecifier: String

    init(axisLabels: [String], data: [Double],
         barWidth: Double = 20.0, barUnitHeight: Double = 15.0,
         dataFormatSpecifier: String = "%.2f") {
        self.axisLabels = axisLabels
        self.data = data
        self.barWidth = CGFloat(barWidth)
        self.barUnitHeight = barUnitHeight
        self.dataFormatSpecifier = dataFormatSpecifier
    }

    var body: some View {
        HStack {
            ForEach(0 ..< axisLabels.count) { count in
                VStack {
                    Spacer()

                    Text("\(data[count], specifier: dataFormatSpecifier)")
                        .font(.footnote)

                    Rectangle()
                        .fill(Color.themeTertiary)
                        .frame(width: barWidth, height: CGFloat(data[count] * barUnitHeight))

                    Text(axisLabels[count])
                }
            }
        }
        .padding()
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        let axis = [1, 2, 3].map { String($0) }
        let data = [30, 50, 40].map { Double($0) }
        BarChart(axisLabels: axis, data: data)
    }
}
