//
//  GroupMessageListUseCase.swift
//  CommonModule
//
//  Created by Carlson Yuan on 2023/8/10.
//

import Foundation
import AgoraChat

public protocol GroupMessageListUseCaseDelegate: AnyObject {
    func groupMessageListUseCase(_ useCase: GroupMessageListUseCase, didReceiveError error: AgoraChatError)
    func groupMessageListUseCase(_ useCase: GroupMessageListUseCase, didUpdateMessages messages: [AgoraChatMessage])
    func groupMessageListUseCase(_ useCase: GroupMessageListUseCase, didUpdateChannel group: AgoraChatGroup)
    func groupMessageListUseCase(_ useCase: GroupMessageListUseCase, didDeleteChannel group: AgoraChatGroup)
}

open class GroupMessageListUseCase: NSObject {
    
    public weak var delegate: GroupMessageListUseCaseDelegate?
    
    open var messages: [AgoraChatMessage] = [] {
        didSet {
            notifyChangeMessages()
        }
    }
    
    open var isLoading: Bool = false

    public private(set) var group: AgoraChatGroup
    
    private let conversation: AgoraChatConversation?
        
    public init(group: AgoraChatGroup) {
        self.group = group
        self.conversation = AgoraChatClient.shared().chatManager?.getConversation(group.groupId, type: .groupChat, createIfNotExist: true)
        super.init()
    }
    
    
    open func loadInitialMessages() {
        
        if let conv = self.conversation {
            conv.loadMessagesStart(fromId: nil, count: 20, searchDirection: .up) { [weak self]  messages, error in
                guard let self = self else { return }
                if let error = error {
                    self.delegate?.groupMessageListUseCase(self, didReceiveError: error)
                    return
                }
                guard let messages = messages else { return }
                self.messages = messages
            }
        }
    }
    open func loadPreviousMessages() {

    }
    
    open func loadNextMessages() {

    }

    
    private func appendPreviousMessages(_ newMessages: [AgoraChatMessage]) {
        guard newMessages.isEmpty == false else { return }
        
        messages.insert(contentsOf: newMessages, at: 0)
    }
    
    private func appendNextMessages(_ newMessages: [AgoraChatMessage]) {
        guard newMessages.isEmpty == false else { return }
        
        messages.append(contentsOf: newMessages)
    }

    
    private func notifyChangeMessages() {
        delegate?.groupMessageListUseCase(self, didUpdateMessages: messages)
    }
}

// MARK: - GroupUserMessageUseCaseDelegate

extension GroupMessageListUseCase: GroupUserMessageUseCaseDelegate {
    public func groupUserMessageUseCase(_ useCase: GroupUserMessageUseCase, addedMessages : [AgoraChatMessage]) {
        appendNextMessages(addedMessages)
    }
    public func groupUserMessageUseCase(_ useCase: GroupUserMessageUseCase, didReceiveError error: Error) {
        
    }
}

