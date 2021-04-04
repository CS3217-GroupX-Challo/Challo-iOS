//
//  MockChatDialogRepository.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo

class MockChatDialogRepository: Repository<String, ChatDialog>, ChatDialogRepositoryProtocol {
    init() {
        insert(MockDialogsMessages.dialogA, key: MockDialogsMessages.dialogA.dialogId)
        insert(MockDialogsMessages.dialogB, key: MockDialogsMessages.dialogB.dialogId)
    }
}
