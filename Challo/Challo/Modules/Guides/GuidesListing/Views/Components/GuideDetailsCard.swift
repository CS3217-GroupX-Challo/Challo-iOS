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
    
    var presenter: GuidesListingPresenter
    
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
                .cornerRadius(10)
                .frame(width: width, height: 200)
                .padding(10)
            if let name = nameDescription {
                Text(name)
                    .bold()
                    .font(.caption2)
                    .padding(5)
                    .frame(height: 5)
            }
            StarRatingsView(rating: guide.rating)
                .padding(5)
                .frame(maxWidth: width)
            GuidesCardDescriptionView(title: "About",
                                      description: guide.biography,
                                      width: width)
                .frame(height: 80)
            GuidesCardDescriptionView(title: "Trails",
                                      description: trailsDescription,
                                      width: width)
                .frame(height: 35)
            GuidesCardDescriptionView(title: "Languages",
                                      description: languagesDescription,
                                      width: width)
                .frame(height: 35)
            GuidesCardDescriptionView(title: "Certifications",
                                      description: creditationsDescription,
                                      width: width)
                .frame(height: 80)
            if let router = presenter.router {
                router.getGuideProfileDetailsPage(guide: guide)
                    .frame(maxHeight: 50)
            }
        }.background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.gray, lineWidth: 0.5)
                .background(Color.white)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 3, y: 3)
        )
        .frame(height: 650)
    }
    
    private func convertTrailsToString(trails: [Trail]) -> String {
        var trailsDescription = ""
        for i in 0..<trails.count {
            trailsDescription += trails[i].title
            if i != trails.count - 1 {
                trailsDescription += ", "
            }
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
