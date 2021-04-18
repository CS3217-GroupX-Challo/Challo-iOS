//
//  ImageableEntity.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

protocol ImageableEntity {
    var images: [String] { get }
}

extension Trail: ImageableEntity {
}

extension Homestay: ImageableEntity {
}
