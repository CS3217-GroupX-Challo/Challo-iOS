//
//  TouristStore.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

class TouristStore {
    private var touristRepository: TouristDetailsRepositoryProtocol
    private var convertor: TouristModelConvertor
    
    init(touristRepository: TouristDetailsRepositoryProtocol,
         convertor: TouristModelConvertor) {
        self.touristRepository = touristRepository
        self.convertor = convertor
    }
    
    func getAllTourists() -> [Tourist] {
        let touristObjects = touristRepository.getAllTourists()
        return touristObjects.map { touristObject in
            convertor.convertTouristPersistenceObjectToTourist(touristObject: touristObject)
        }
    }
    
    func saveTourists(tourists: [Tourist]) {
        let touristObjects = tourists.map { tourist in
            convertor.convertTouristToTouristPersistenceObject(tourist: tourist)
        }
        
        touristRepository.saveTourists(touristObjects: touristObjects)
    }
}
