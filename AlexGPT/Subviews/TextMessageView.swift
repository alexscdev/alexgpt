//
//  TextMessageView.swift
//  AlexGPT
//
//  Created by Alejandro Sanchez Caballero on 15/5/23.
//

import SwiftUI
import SwiftOpenAI

struct TextMessageView: View {
    var message: MessageChatGPT
    
    var body: some View {
        HStack{
            if message.role == .user {
                
                
                Spacer()
                Text(message.text)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue)
                    )
                    .frame(maxWidth: 240, alignment: .trailing)
            } else{
                Text(message.text)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray)
                    )
                    .frame(maxWidth: 240, alignment: .leading)
                Spacer()
            }
        }
    }
}

struct TextMessageView_Previews: PreviewProvider {
    static let chatGPTMessage: MessageChatGPT = .init(text: "Hola SwiftBeta, aqui estoy para ayudarte y contestar todas tus preguntas", role: .system)
    static let myMessage: MessageChatGPT = .init(text: "¿Cuando se lanzo el primer Iphone?", role: .user)
    
    
    static var previews: some View {
        Group{
            TextMessageView(message: Self.chatGPTMessage)
                .previewDisplayName("ChatGPT Message")
            TextMessageView(message: Self.myMessage)
                .previewDisplayName("My Message")
        }
        .previewLayout(.sizeThatFits)
    }
}
