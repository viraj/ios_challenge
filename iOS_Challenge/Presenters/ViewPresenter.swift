//
//  ViewPresenter.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/9/21.
//

import Foundation

protocol ViewPresenterDelegate {
    func updateView(user: User)
    func responseFailed()
}

class ViewPresenter  {
    var delegate: ViewPresenterDelegate?
    
    func loadData(reloadFromServer: Bool = false) {
        let github = GitHub(token: GITHUB_TOKEN, fromServer: reloadFromServer)
        do {
            if let user = try github.userInfo(user: GITHUB_USER_LOGIN) {
                self.delegate?.updateView(user: user)
            }
        } catch {
            print("🎋 - \(error)")
            self.delegate?.responseFailed()
        }
    }
}
