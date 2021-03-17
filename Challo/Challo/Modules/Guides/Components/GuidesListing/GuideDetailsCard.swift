//
//  GuideDetailsCard.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuideDetailsCard: View {
    var guide: Guide
    var width: CGFloat
    
    var rating: Decimal = 4.0
    
    var nameDescription: String? {
        guide.name
    }
    
    var trailsDescription: String {
        convertTrailsToString(trails: guide.trails)
    }
    
    var languagesDescription: String? {
        convertStringArrayToString(strings: guide.languages)
    }
    
    var creditationsDescription: String? {
        convertStringArrayToString(strings: guide.accreditations)
    }
    
    var body: some View {
        Card {
            Image(guide.profileImg ?? "avatar-image")
                .resizable()
                .scaledToFit()
                .frame(width: width * 2 / 3)
                .cornerRadius(10)
                .padding(10)
            if let name = nameDescription {
                Text(name)
                    .bold()
                    .font(.caption2)
                    .padding(5)
            }
            StarRatingsView(rating: (guide.rating as NSDecimalNumber).doubleValue)
                .padding(5)
            GuidesCardDescriptionView(title: "Trails",
                                      description: trailsDescription,
                                      width: width * 2 / 3)
            GuidesCardDescriptionView(title: "Languages",
                                      description: languagesDescription,
                                      width: width * 2 / 3)
            GuidesCardDescriptionView(title: "Certifications",
                                      description: creditationsDescription,
                                      width: width * 2 / 3)
            Button(action: {
                // TODO add navigation
            }) {
                Text("More info")
                    .overlay(RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.themeTertiary, lineWidth: 2))
            }
        }
        .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 0.5))
        .shadow(radius: 5)
    }
    
    private func convertTrailsToString(trails: [Trail]) -> String {
        var trailsDescription = ""
        for i in 0..<trails.count {
            if i != trails.count - 1 {
                trailsDescription += ", "
            }
            trailsDescription += trails[i].title
        }
        return trailsDescription
    }
    
    private func convertStringArrayToString(strings: [String]?) -> String? {
        guard let stringArray = strings else {
            return nil
        }
        
        var result = ""
        for i in 0..<stringArray.count {
            result += stringArray[i]
            if i != stringArray.count - 1 {
                result += ", "
            }
        }
        return result
    }
}
