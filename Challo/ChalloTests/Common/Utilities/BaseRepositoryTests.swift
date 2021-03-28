//
//  BaseRepositoryTests.swift
//  ChalloTests
//
//  Created by Shao Yi on 28/3/21.
//

@testable import Challo
import XCTest

class BaseRepositoryTests: XCTestCase {
    
    func testGetAll_nonEmptyRepo_allEntitiesObtained() {
        var initialRepo = [UUID: String]()
        let sampleUUID = UUID()
        let sampleStr = "Hello World"
        initialRepo[sampleUUID] = sampleStr
        let repository = BaseRepository<String>(initialRepo)
        let retrievedEntities = repository.getAll()
        XCTAssertTrue(retrievedEntities.count == 1)
        XCTAssertEqual(retrievedEntities, [sampleStr])
    }
    
    func testGetAll_emptyRepo_emptyEntities() {
        let repository = BaseRepository<String>()
        XCTAssertTrue(repository.getAll().isEmpty)
    }
    
    func getGetByKey_validKey_entityObtained() {
        var initialRepo = [UUID: String]()
        let sampleUUIDA = UUID()
        let sampleStrA = "Hello World"
        let sampleUUIDB = UUID()
        let sampleStrB = "Bye World"
        initialRepo[sampleUUIDA] = sampleStrA
        initialRepo[sampleUUIDB] = sampleStrB
        let repository = BaseRepository<String>(initialRepo)
        
        let retrievedEntityA = repository.getByKey(sampleUUIDA)
        XCTAssertEqual(retrievedEntityA, sampleStrA)
        let retrievedEntityB = repository.getByKey(sampleUUIDB)
        XCTAssertEqual(retrievedEntityB, sampleStrB)
    }
    
    func testGetByKey_invalidKey_entityObtained() {
        var initialRepo = [UUID: String]()
        let sampleUUIDA = UUID()
        let sampleStrA = "Hello World"
        initialRepo[sampleUUIDA] = sampleStrA
        let repository = BaseRepository<String>(initialRepo)
        
        let retrievedEntityA = repository.getByKey(UUID())
        XCTAssertNil(retrievedEntityA)
    }
    
    func testStore_nonExistingKey_entityStored() {
        let sampleUUIDA = UUID()
        let sampleStrA = "Hello World"
        let repository = BaseRepository<String>()
        
        let storedEntityKey = repository.store(sampleStrA, key: sampleUUIDA)
        XCTAssertEqual(storedEntityKey, sampleUUIDA)
        XCTAssertEqual(sampleStrA, repository.getByKey(sampleUUIDA))
    }
    
    func testStore_existingKey_entityNotStored() {
        let sampleUUIDA = UUID()
        let sampleStrA = "Hello World"
        let sampleStrB = "Bye World"
        let repository = BaseRepository<String>()
        
        repository.store(sampleStrA, key: sampleUUIDA)
        let returnedEntityForExisitngKey = repository.store(sampleStrB, key: sampleUUIDA)
        XCTAssertNil(returnedEntityForExisitngKey)
        let retrievedEntities = repository.getAll()
        XCTAssertTrue(retrievedEntities.count == 1)
        XCTAssertEqual(retrievedEntities, [sampleStrA])
    }
    
    func testDeleteByKey_existingKey_entityDeleted() {
        var initialRepo = [UUID: String]()
        let sampleUUIDA = UUID()
        let sampleStrA = "Hello World"
        let sampleUUIDB = UUID()
        let sampleStrB = "Bye World"
        initialRepo[sampleUUIDA] = sampleStrA
        initialRepo[sampleUUIDB] = sampleStrB
        let repository = BaseRepository<String>(initialRepo)
        
        let deletedEntityA = repository.deleteByKey(sampleUUIDA)
        XCTAssertEqual(deletedEntityA, sampleStrA)
        XCTAssertNil(repository.getByKey(sampleUUIDA))
        XCTAssertEqual(sampleStrB, repository.getByKey(sampleUUIDB))
    }
    
    func testDeleteByKey_nonExistingKey_entityDeleted() {
        var initialRepo = [UUID: String]()
        let sampleUUIDA = UUID()
        let sampleStrA = "Hello World"
        let sampleUUIDB = UUID()
        let sampleStrB = "Bye World"
        initialRepo[sampleUUIDA] = sampleStrA
        initialRepo[sampleUUIDB] = sampleStrB
        let repository = BaseRepository<String>(initialRepo)
        
        let returnedEntityForNonExistingKey = repository.deleteByKey(UUID())
        XCTAssertNil(returnedEntityForNonExistingKey)
        let retrievedEntities = repository.getAll()
        XCTAssertTrue(retrievedEntities.count == 2)
        XCTAssertEqual(retrievedEntities, [sampleStrA, sampleStrB])
    }
    
    func testUpdateByKey_existingKey_entityDeleted() {
        var initialRepo = [UUID: String]()
        let sampleUUIDA = UUID()
        let sampleStrA = "Hello World"
        let updatedStr = "Bye World"
        initialRepo[sampleUUIDA] = sampleStrA
        let repository = BaseRepository<String>(initialRepo)
        
        let returnedEntity = repository.updateByKey(entity: updatedStr, key: sampleUUIDA)
        XCTAssertEqual(returnedEntity, updatedStr)
        XCTAssertEqual(updatedStr, repository.getByKey(sampleUUIDA))
    }
    
    func testUdpateByKey_nonExistingKey_entityDeleted() {
        var initialRepo = [UUID: String]()
        let sampleUUIDA = UUID()
        let sampleStrA = "Hello World"
        let sampleUUIDB = UUID()
        let sampleStrB = "Bye World"
        initialRepo[sampleUUIDA] = sampleStrA
        initialRepo[sampleUUIDB] = sampleStrB
        let repository = BaseRepository<String>(initialRepo)
        
        let returnedEntityForNonExistingKey = repository.updateByKey(entity: "Invalid", key: UUID())
        XCTAssertNil(returnedEntityForNonExistingKey)
        let retrievedEntities = repository.getAll()
        XCTAssertTrue(retrievedEntities.count == 2)
        XCTAssertEqual(retrievedEntities, [sampleStrA, sampleStrB])
    }

}
