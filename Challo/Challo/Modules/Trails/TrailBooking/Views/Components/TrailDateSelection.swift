//
//  TrailDateSelection.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailDateSelection: View {

    @Binding var selectedDate: Date

    var body: some View {
        DatePicker("Date",
                   selection: $selectedDate,
                   displayedComponents: .date)
    }
}

struct TrailDateSelection_Previews: PreviewProvider {
    static var previews: some View {
        TrailDateSelection(selectedDate: .constant(Date()))
    }
}
