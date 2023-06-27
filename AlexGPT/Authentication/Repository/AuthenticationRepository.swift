//
//  AuthenticationRepository.swift
//  SavedLink
//
//  Created by Alejandro Sanchez Caballero on 22/6/23.
//

import Foundation

final class AuthenticationRepository {
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDataSource
    
    init(authenticationFirebaseDatasource: AuthenticationFirebaseDataSource = AuthenticationFirebaseDataSource()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
    }
    
    func getCurrentUser() -> User? {
        authenticationFirebaseDatasource.getCurrentUser()
    }
    
    func createnewUser(email: String, password: String, completionBlock: @escaping (Result <User, Error>) -> Void) {
        authenticationFirebaseDatasource.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result <User, Error>) -> Void) {
        authenticationFirebaseDatasource.login(email: email, password: password, completionBlock: completionBlock)
    }
    
    func logout() throws {
        try authenticationFirebaseDatasource.logout()
    }
}
