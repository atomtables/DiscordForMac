//
//  DFMLogOutUpdater.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 18/06/2024.
//

import Foundation

func DFMLogOutUpdater() {
    NotificationCenter.default.addObserver(
        forName: Notification.Name("DFMLogOutUpdate"),
        object: nil,
        queue: nil
    ) { notification in
        PrintDebug("attempting to log you out")
        var userinfo = UserDefaults.standard.object(forKey: "DFMUserInformation") as? [String: Data] ?? [String: Data]()
        userinfo.removeValue(forKey: DFMConstants.DFMSecrets.email)
        UserDefaults.standard.set(userinfo, forKey: "DFMUserInformation")
        DFMConstants.DFMSecrets.token = ""
        PrintDebug("new token should now be: \(DFMConstants.DFMSecrets.token)")
        DFMInformation.shared.keychain[DFMConstants.DFMSecrets.email] = nil
        PrintDebug("new key should now be: \(DFMInformation.shared.keychain[DFMConstants.DFMSecrets.email] ?? "returned nil")")


        DFMInformation.shared.keychain[DFMConstants.DFMSecrets.email] = nil
        PrintDebug("new key should now be: \(DFMInformation.shared.keychain[DFMConstants.DFMSecrets.email] ?? "returned nil")")
        if let __ = try? DFMInformation.shared.keychain.remove(DFMConstants.DFMSecrets.email) {
            PrintDebug("new value is \(__)")
        } else {
            PrintDebug("returned nil again for good measure")
        }

        DFMInformation.shared.loadingScreen = (false, "Logged out")
        DFMInformation.shared.userInfo = nil
        DFMInformation.shared.guildList = nil
        DFMInformation.shared.error = nil
        DFMInformation.shared.userReferences = [:]
        DFMInformation.shared.privateChannels = []
        DFMInformation.shared.presences = []
        DFMInformation.shared.subscribedChannels = Set()
        DFMInformation.shared.messages = [:]
        DFMInformation.shared.liveMessages = [:]

        DFMInformation.shared.gateway.stop()
        var userarr = UserDefaults.standard.object(forKey: "DFMUserArray") as? [[String]] ?? [[String]]()
        userarr = userarr.filter {$0[0] != DFMConstants.DFMSecrets.email}
        UserDefaults.standard
            .set(userarr, forKey: "DFMUserArray")
        DFMInformation.shared.keychainItems = userarr
        DFMInformation.shared.shouldShowAccountChooser = true
        DFMInformation.shared.shouldLogOut = (true, "")
    }
}
