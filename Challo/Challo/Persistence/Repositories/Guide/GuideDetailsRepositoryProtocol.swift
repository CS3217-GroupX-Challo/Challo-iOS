//
//  GuideDetailsRepositoryProtocol.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

protocol GuideDetailsRepositoryProtocol {
    func getAllGuides() -> [GuidePersistenceObject]
    func saveGuides(guideObjects: [GuidePersistenceObject])
}
