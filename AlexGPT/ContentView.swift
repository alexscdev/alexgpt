//
//  ContentView.swift
//  AlexGPT
//
//  Created by Alejandro Sanchez Caballero on 12/5/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @StateObject var viewModel = ViewModel()
    @State var prompt: String = "" //Entrada de texto
    
    var body: some View {
        VStack {
            ConversationView()
                .environmentObject(viewModel)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack{
                TextField("Escribe aquí!",
                          text: $prompt,
                          axis: .vertical)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .lineLimit(6)
                
                Button{
                    Task{
                        let mensaje = prompt
                        prompt = ""
                        await viewModel.send(message: mensaje)
                        
                        
                        
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color.white)
                        .frame(width: 44,height: 44)
                        .background(Color.blue)
                        .cornerRadius(22)
                }
                .padding(.leading, 8)
            }
            Button("Logout") {
                authenticationViewModel.logout()
            }
            .padding(.top, 20)

        }
            .padding()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authenticationViewModel: AuthenticationViewModel())
    }
}



