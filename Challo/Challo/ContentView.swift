//
//  ContentView.swift
//  Challo
//
//  Created by Tan Le Yang on 12/3/21.
//

import SwiftUI
import FBSDKLoginKit

struct ContentView: View {
    var body: some View {
        RegisterPage(
            loginPresenter: LoginPresenter(
                interactor: LoginInteractor()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage(
            loginPresenter: LoginPresenter(
                interactor: LoginInteractor()))
    }
}

struct Home: View {

    @AppStorage("logged") var logged = false
    @AppStorage("email") var email = "email"
    @State var manager = LoginManager()
        

    var body: some View {
        
        Button(action: {
            
            manager.logIn(permissions: ["public_profile", "email"],
                          from: nil) { result, err in
                ApplicationDelegate.initializeSDK(nil)
                if err != nil {
                    print("ERROR: \(err!.localizedDescription)")
                    return
                }

                if !result!.isCancelled {
                    print("result is not cancelled and error is nil")
                    logged = true
                    
                    let request = GraphRequest(graphPath: "me",
                                               parameters: ["fields": "email"])
                    
                    request.start { (_, res, _) in
                        guard let profileData = res as? [String : Any] else {
                            print("fail")
                            return
                        }
                        print(profileData)
                        email = profileData["email"] as! String
                    }
                }
            }
        }, label: {
            Text("FB Login")
                .fontWeight(.bold)
        })
        
        Text(email)
            .fontWeight(.bold)
    }
}
