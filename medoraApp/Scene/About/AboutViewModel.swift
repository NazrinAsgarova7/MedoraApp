//
//  AboutViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 26.12.25.
//

import Foundation

struct AboutSectionModel {
    let sectionType: SectionType
    let sectionTitle: String
    let sectionHeaderHeight: CGFloat
    let items: [AboutSectionItemModel]
    
    enum SectionType {
        case mission, feature
    }
}

struct AboutSectionItemModel {
    let icon: String
    let title: String
    let subtitle: String
}

class AboutViewModel {
    enum ViewState {
        case success
        case error(error: String)
    }
    let manager: AboutUseCase
    var info: AboutModel?
    
    var data = [AboutSectionModel]()
    
    var completion: ((ViewState) -> Void)?
    
    init(manager: AboutUseCase) {
        self.manager = manager
    }
    
    func getAboutScreen() async {
        do {
            let result = try await manager.getAboutScreenInfo(endpoint: .getAbout)
            info = result?.data
            
            let items = info?.why?.items ?? []
            let whyItems: [AboutSectionItemModel] = items.map { data in
                    .init(icon: data.icon ?? "",
                          title: data.title ?? "",
                          subtitle: data.subtitle ?? "")
            }
            
            self.data = [.init(sectionType: .mission,
                               sectionTitle: info?.mission?.title ?? "",
                               sectionHeaderHeight: 200,
                               items: [.init(icon: "", title: info?.mission?.text ?? "", subtitle: "")]),
                         .init(sectionType: .feature,
                               sectionTitle: info?.why?.title ?? "",
                               sectionHeaderHeight: 20,
                               items: whyItems)]
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
