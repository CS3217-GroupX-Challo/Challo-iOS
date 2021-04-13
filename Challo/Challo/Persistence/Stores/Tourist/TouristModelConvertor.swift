//
//  TouristModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

class TouristModelConvertor {
    func convertTouristToTouristPersistenceObject(tourist: Tourist) -> TouristPersistenceObject {
        TouristPersistenceObject(userId: tourist.userId,
                                 email: tourist.email,
                                 profileImg: tourist.profileImg,
                                 name: tourist.name,
                                 phone: tourist.phone,
                                 dateJoined: tourist.dateJoined,
                                 sex: tourist.sex)
    }
    
    func convertTouristPersistenceObjectToTourist(touristObject: TouristPersistenceObject) -> Tourist {
        Tourist(userId: touristObject.userId,
                email: touristObject.email,
                profileImg: touristObject.profileImg,
                name: touristObject.name,
                phone: touristObject.phone,
                dateJoined: touristObject.dateJoined,
                sex: touristObject.sex)
    }
}
