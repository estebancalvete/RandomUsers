//
//  User.swift
//  RandomUsers
//
//  Created by Esteban Calvete Iglesias on 2/5/22.
//

import Foundation


// (2) We add Decodable conformance to convert the JSON into a Response. So (3), because any custom structures used inside Response must also conform to Decodable, we need to have User and Name conform to Decodable too.
struct Response: Decodable {
    let users: [User]
    
    // (4) We use CodingKeys enum to decode the JSON properly as the response doesn't contain any "users" key. The users case has to have a raw value of "results".
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

// (1) Ultimately, each User instance will be displayed using a List with requires the items conform to Identifiable.
struct User: Decodable, Identifiable {
    let id: String
    let name: Name
    
    // (6) Computed property to make it easier to display the full name.
    var fullName: String {
        name.title + ". " + name.first + " " + name.last
    }
    
    // (5.3) The initializer will decode the value at the "name" key into the name property. Next, we get the value associated with the uuid key in the nested LoginInfoCodingKeys container. By using the nestedContainer to access the uuid for the login key, we can assign the id of the User to the appropiate value.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        let loginInfo = try values.nestedContainer(keyedBy: LoginInfoCodingKeys.self, forKey: .login)
        id = try loginInfo.decode(String.self, forKey: .uuid)
        
    }
    
    // (5.1) We need to declare this CodingKeys because there is not an "id" key on the JSON response, instead we have a "login" key.
    enum CodingKeys: String, CodingKey {
        case login
        case name
    }
    
    // (5.2) It's not enough to add a raw value for the uuid case because it's nested so we do (5.3)
    enum LoginInfoCodingKeys: String, CodingKey {
        case uuid
    }
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}


