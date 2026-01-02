//
//  ProfileViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 27.11.25.
//

import Foundation

class ProfileViewModel {
    enum ViewState {
        case success, error(error: String)
    }
    let icons = [("text.document", "Appointments"),
                 ("shield", "Privacy & Security"),
                 ("questionmark", "Help & Support"),
                 ("rectangle.portrait.and.arrow.right", "Logout")]
    
    let iconsForHelp = [
        ("envelope","medora@gmail.com"),
        ("phone","012-789-98-98")
    ]
    let manager: ProfileUseCase
    var completion: ((ViewState) -> Void)?
    
    init(manager: ProfileUseCase) {
        self.manager = manager
    }
   
    func getUserData(key: UserDefaultEnum) -> String {
        UserDefaultManager.shared.getData(key: key)
    }
    
    func getProfileImage() -> String {
        UserDefaultManager.shared.getImage()
    }
    
    func saveProfilePhoto(data: Data) async {
        do {
            let result = try await manager.uploadProfilePhoto(endpoint: .uploadPhoto(userId: UserDefaultManager.shared.getData(key: .id)), data: data)
            UserDefaultManager.shared.saveProfileImage(result?.data?.user?.photoURL)
            Task { @MainActor in
                completion?(.success)
            }
        } catch {
            Task { @MainActor in
                completion?(.error(error: error.localizedDescription))
            }
        }
    }
}
