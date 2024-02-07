//
//  GroupUserMessageUseCase.swift
//  CommonModule
//
//  Created by Carlson Yuan on 2023/8/11.
//

import Foundation
import AgoraChat

public protocol GroupUserMessageUseCaseDelegate: AnyObject {
    func groupUserMessageUseCase(_ useCase: GroupUserMessageUseCase, didReceiveError error: Error)
    func groupUserMessageUseCase(_ useCase: GroupUserMessageUseCase, addedMessages: [AgoraChatMessage])
}

open class GroupUserMessageUseCase {
    
    public let group: AgoraChatGroup
    public weak var delegate: GroupUserMessageUseCaseDelegate?
    public init(group: AgoraChatGroup) {
        self.group = group
    }
    
    open func sendMessage(_ text: String, completion: @escaping (Result<AgoraChatMessage, Error>) -> Void)  -> AgoraChatMessage? {
        
        let body = AgoraChatTextMessageBody.init(text: text)
        let message = AgoraChatMessage.init(conversationID: group.groupId, body: body, ext: nil)
        message.chatType = .groupChat
        AgoraChatClient.shared().chatManager?.send(message, progress: nil, completion: { message, error in
            if let error = error {
                let err = NSError(domain: error.errorDescription, code: error.code.rawValue) as Error
                self.delegate?.groupUserMessageUseCase(self, didReceiveError: err)
                completion(.failure(err))
                return
            }
            
            guard let message = message else { return }
            self.delegate?.groupUserMessageUseCase(self, addedMessages: [message])
            completion(.success(message))
        })
        return message
    }
    
}