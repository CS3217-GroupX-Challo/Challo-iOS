//
//  TouristModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

class TouristModelConvertor: ModelConvertor {
    typealias Model = Tourist
    typealias PersistenceObject = TouristPersistenceObject
    
    func convertModelToPersistenceObject(model: Tourist) -> TouristPersistenceObject {
        TouristPersistenceObject(userId: model.userId,
                                 email: model.email,
                                 profileImg: model.profileImg,
                                 name: model.name,
                                 phone: model.phone,
                                 dateJoined: model.dateJoined,
                                 sex: model.sex)
    }
    
    func convertPersistenceObjectToModel(object: TouristPersistenceObject) -> Tourist {
        Tourist(userId: object.userId,
                email: object.email,
                profileImg: object.profileImg,
                name: object.name,
                phone: object.phone,
                dateJoined: object.dateJoined,
                sex: object.sex)
    }
}
