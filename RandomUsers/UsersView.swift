//
//  UsersView.swift
//  RandomUsers
//
//  Created by Esteban Calvete Iglesias on 29/4/22.
//

import SwiftUI

struct UsersView: View {
    
    // We declare an object of UserData that will generate a UserData instance with ten users into the userData.users.
    // We mark it with the @StateObject modifier since it should update the UI if the users change. Because of this we will need to provide the Published modifier to the UserData.users to update any subscribers with the newly published data. And finally to be able to use the Published modifier, the UserData class needs to conform to ObservableObject protocol.
    @StateObject var userData = UserData()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Raw JSON Data:")
                ScrollView {
                    Text(userData.users)
                }
            }
            .padding()
            .navigationTitle("Random Users")
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
