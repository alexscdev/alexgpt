//
//  ViewModel.swift
//  AlexGPT
//
//  Created by Alejandro Sanchez Caballero on 14/5/23.
//

import Foundation
import SwiftOpenAI

final class ViewModel: ObservableObject{
    
    @Published var messages: [MessageChatGPT] = [.init(text: "¡Hola! Soy tu asistente, estoy aqui para contestarte todas las preguntas que tengas", role: .system)]
    
    @Published var currentMessage: MessageChatGPT = .init(text: "", role: .assistant)
    

    
    var openAI = SwiftOpenAI(apiKey: "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")
    
    func send(message: String) async{
        let optionalParameters = ChatCompletionsOptionalParameters(temperature: 0.7, stream: true, maxTokens: 300)
        
        await MainActor.run{
            let myMessage = MessageChatGPT(text: message, role: .user)
            self.messages.append(myMessage)
            
            self.currentMessage = MessageChatGPT(text: "", role: .assistant)
            self.messages.append(self.currentMessage)
        
        }
        
        do {
            let stream = try await openAI.createChatCompletionsStream(model: .gpt3_5(.turbo),
                                                                      messages: messages,
                                                                      optionalParameters: optionalParameters)
            
            for try await response in stream {
                print(response)
                await onReceive(newMessage: response)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    @MainActor
    private func onReceive(newMessage: ChatCompletionsStreamDataModel){
        let lastMessage = newMessage.choices[0]
        guard lastMessage.finishReason == nil else{
            print("Finished streaming messages")
            return
        }
        guard let content = lastMessage.delta?.content else{
            print("message with no content")
            return
        }
        currentMessage.text = currentMessage.text + content
        messages[messages.count - 1].text = currentMessage.text    }
}

