//
//  MultiSelectorPicker.swift
//  Challo
//
//  Created by Ying Gao on 14/4/21.
//

import Foundation
import SwiftUI

/**
 A drop down picker that allows for multiple selections.
 Heavily derived from https://dev.to/jeehut/multi-selector-in-swiftui-5heg
 and https://anthonycodesofficial.medium.com/swiftui-tutorial-how-to-create-a-floating-drop-down-menu-cc1562dbd48f
 */
struct MultiSelectorPicker<Label: View, Selectable: Identifiable & Hashable>: View {

    @State var expand = false

    let label: Label
    let options: [Selectable]
    let optionToString: (Selectable) -> String

    @Binding var selected: Set<Selectable>

    var body: some View {
        VStack {
            HStack {
                label
                Spacer()
                Text(selectedOptionsSummary)
                Image(systemName: expand ? "chevron.up" : "chevron.down")
            }
            .padding()
            .onTapGesture {
                expand.toggle()
            }

            if expand {
                optionsList.padding()
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15.0)
                .stroke(Color.themeTertiary, lineWidth: 2.0)
        )
    }

    var selectedOptionsSummary: String {
        ListFormatter.localizedString(byJoining: selected.map(optionToString))
    }

    var optionsList: some View {
        List {
            ForEach(options) { selectable in
                selectableButtonContents(option: selectable)
                    .tag(selectable.id)
                    .onTapGesture {
                        toggleSelection(option: selectable)
                    }
            }
            .listStyle(GroupedListStyle())
        }
    }

    func selectableButtonContents(option: Selectable) -> some View {
        HStack {
            Text(optionToString(option))
            Spacer()
            if selected.contains { $0.id == option.id } {
                Image(systemName: "checkmark").foregroundColor(.accentColor)
            }
        }
    }

    func toggleSelection(option: Selectable) {
        if selected.contains(where: { $0.id == option.id }) {
            selected.remove(option)
        } else {
            selected.insert(option)
        }
    }
}

struct MultiSelectorPicker_Previews: PreviewProvider {

    struct IdentifiableString: Identifiable, Hashable {
        var id: String
    }

    static var previews: some View {
        let options = ["A", "B", "C"].map { IdentifiableString(id: $0) }
        let selected = ["A", "B"].map { IdentifiableString(id: $0) }
        MultiSelectorPicker(
            label: Text("Test"),
            options: options,
            optionToString: { $0.id },
            selected: .constant(Set(selected))
        )
    }
}
