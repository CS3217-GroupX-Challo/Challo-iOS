//
//  HostModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 18/4/21.
//

import Foundation

class HostModelConvertor: ModelConvertor {
    typealias Model = Host
    typealias PersistenceObject = HostPersistenceObject
    
    func convertModelToPersistenceObject(model: Host) -> HostPersistenceObject {
        HostPersistenceObject(userId: model.userId,
                              email: model.email,
                              profileImg: model.profileImg,
                              name: model.name,
                              phone: model.phone,
                              dateJoined: model.dateJoined,
                              sex: model.sex)
    }
    
    func convertPersistenceObjectToModel(object: HostPersistenceObject) -> Host {
        Host(userId: object.userId,
             email: object.email,
             profileImg: object.profileImg,
             name: object.name,
             phone: object.phone,
             dateJoined: object.dateJoined,
             sex: object.sex)
    }
    
}
