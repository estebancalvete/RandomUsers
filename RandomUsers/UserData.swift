//
//  UserData.swift
//  RandomUsers
//
//  Created by Esteban Calvete Iglesias on 29/4/22.
//

import Foundation

// Last step: assign the MainActor. Please read why after understanding the rest of the class and its interaction with the UIView.
// Inside the init() function loadUsers(), self.users MUST be set on the main thread. This is because users is an observed object and being published to UsersView. All UI updates must occur on the main thread. We can ensure that the UI is updated in the main thread by adding the MainActor attribute at the top of the UserData class.
@MainActor

// This class is set to store the users generated from the UserFetchingClient struct.
// The class has to conform to ObservableObject because it has a @Published property that will update any subscriber views. UsersView will use an object that is an instance of UserData class.
class UserData: ObservableObject {
    
    // We declare the property users with the @Published modifier to update any subscribers. UsersView will be updated with any change to its @Published users property.
    @Published var users: String = ""
    
    // We add an initializer that will generate random users by calling the UserFetchingClient.getUsers() function call.
    // We use try and await keywords because getUsers() is an asynchronous throwing function.
    // We use a do-catch block to catch and print any errors.
    // As we are using an async function we need to declare the init() as asynchronous too, otherwise we will get a compiling error. But in this case, it may be difficult to follow asynchronous initialization, so it's more appropriate to use a Task to execute the getUsers() async function.
    // For organizational purposes, we will move the task logic into a separate function loadUsers(), that will hold the do-cathc block to call the getUsers() function.
    init() {
        Task {
            await loadUsers()
        }
    }
    
    func loadUsers() async {
        do {
            let users = try await UserFetchingClient.getUsers()
            self.users = users
        }
        catch {
            print(error)
        }
    }
}
