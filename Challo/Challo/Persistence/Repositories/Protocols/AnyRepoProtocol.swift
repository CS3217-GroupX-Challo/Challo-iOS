//
//  AnyRepoProtocol.swift
//  Challo
//
//  Created by Kester Ng on 17/4/21.
//

private class _AnyRepoProtocolBase<ConcreteType>: RepoProtocol {
    typealias PersistenceObject = ConcreteType
    
    // swiftlint:disable unavailable_function
    func getAll() -> [ConcreteType] {
        fatalError("To be overriden by other classes as this is an abstract class")
    }
    
    // swiftlint:disable unavailable_function
    func save(objects: [ConcreteType]) {
        fatalError("To be overriden by other classes as this is an abstract class")
    }
}

private class _AnyRepoProtocolBox<ImplementingType: RepoProtocol>: _AnyRepoProtocolBase
    <ImplementingType.PersistenceObject> {
    private let wrappedInstance: ImplementingType
    
    init(_ repo: ImplementingType) {
        self.wrappedInstance = repo
    }
    
    override func getAll() -> [ImplementingType.PersistenceObject] {
        wrappedInstance.getAll()
    }
    
    override func save(objects: [ImplementingType.PersistenceObject]) {
        wrappedInstance.save(objects: objects)
    }
}

// A type erasure class for RepoProtocol
final class AnyRepoProtocol<ConcreteType>: RepoProtocol {
    private let _box: _AnyRepoProtocolBase<ConcreteType>
    
    init<ImplementingType: RepoProtocol>(_ repo: ImplementingType) where
        ImplementingType.PersistenceObject == ConcreteType {
        self._box = _AnyRepoProtocolBox(repo)
    }
    
    func getAll() -> [ConcreteType] {
        _box.getAll()
    }
    
    func save(objects: [ConcreteType]) {
        _box.save(objects: objects)
    }
}
