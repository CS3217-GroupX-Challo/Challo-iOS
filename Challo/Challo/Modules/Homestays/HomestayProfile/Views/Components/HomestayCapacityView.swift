//
//  HomestayCapacityView.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayCapacityView: View {
    @EnvironmentObject var presenter: HomestayProfilePresenter
    
    let capacity: HomestayCapacity
    
    func makeCapacity(bedroom: Bedroom, index: Int) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: bedroom.bed.getIcon())
                Image(systemName: "bed.double.fill")
            }
            Text("Bedroom \(index + 1)")
                .bold()
            Text("\(bedroom.bedQuantity) \(bedroom.bed.rawValue)")
                .foregroundColor(.gray)
        }.padding()
        .frame(width: 150, height: 150)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1.5)
        )
        
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(capacity.bedrooms.indices, id: \.self) { index in
                    makeCapacity(bedroom: capacity.bedrooms[index], index: index)
                }
            }
        }
    }
}
