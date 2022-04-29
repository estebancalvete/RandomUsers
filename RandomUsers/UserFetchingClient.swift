//
//  UserFetchingClient.swift
//  RandomUsers
//
//  Created by Esteban Calvete Iglesias on 29/4/22.
//

import Foundation

// The purpose of this structure is to reach out to the Random User Generator API and retrieve random users.

// This structure will send a URL Request, ask ofr specific data, and retrieve that data from the Random User Generator API.

struct UserFetchingClient {
    
    // url property is the URL from where we will request the data.
    // Porperty declared as static as it doesn't need to belong to a specific instance of UserFetchingClient.
    static private let url = URL(string: "https://randomuser.me/api/?results=10&format=pretty")!
    
    // The function getUsers() is defined as async because it uses the asynchronous function URLSession.shared.data(from:), otherwise we will get a compiling error.
    // The function is also marked with throws because it can throw an errror using the String(data:, encoding:) function that can throw error.
    static func getUsers() async throws -> String {
        
        // The function URLSession.shared.data(from: URL) requests data from a specified URL. The function returns 2 value types: Data and URLResponse. The URLResponse will contain associanted metadata, and the Data will contain any data in the response. We will only use the Data value.
        // Since the function return 2 values, we define a tuple (data, _) to store the data. The second property is an _ because we don't need to use the URLResponse in this project.
        // To execute an asynchronous function, you must use the await keyword or create an asynchronous variable. Here we create an async variable to execute the URL request immediately and doesn't block the main thread.
        // By default URLSession operations occur on a background thread.
        async let (data, _) = URLSession.shared.data(from: url)
        
        // The data will return as a Data type, for usability and readability purposees, we transform the JSON Data to a SJON String
        // We use the awit keyword because data is declared as async and we need to wait for it.
        // We use the try keyword because String(data:, encoding:) can throw an error.
        return try await String(data: data, encoding: .utf8)!
    }
}
