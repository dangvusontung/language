//
//  PersistantGoogleAIChatManager.swift
//  Language Learning
//
//  Created by TungDVS on 31/12/2023.
//

import Foundation
import RealmSwift

class PersistantGoogleAIChatManager {
   let realm: Realm?

   init() {
        do {
            realm = try Realm()
        } catch {
            realm = nil
            print("Failed to open Realm")
        }
   }


//   func saveChat

}
