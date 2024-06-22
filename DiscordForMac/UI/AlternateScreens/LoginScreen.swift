//
//  LoginScreen.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 14/06/2024.
//

import Foundation
import SwiftUI

enum DFMTwoStepLoginType: String {
    case totp = "Authenticator"
    case motp = "Mobile SMS"
    case backup = "Backup"
}

struct LoginScreen: View {
    @State var showBeginButton: Bool = false
    @State var showLoginScreen: Bool = false
    @State var showLoginScreenAnimation: Bool = false

    @State var email: String = ""
    @State var password: String = ""
    @State var biometricProtect: Bool = false

    @State var showTwoStepPrompt: Bool = false
    @State var twoStepAuthTicket: String = ""
    @State var twoStepAuthTypesEnabled: [DFMTwoStepLoginType] = []
    @State var twoStepAuthType: DFMTwoStepLoginType = .totp
    @State var twoStepSMSSent: Bool = false
    @State var twoStepPhoneNumber: String = ""
    @State var twoStepCode: String = ""

    @State var loading: Bool = false
    @State var error: (DFMErrorPriority, String)? = nil

    // 37 is the sweet spot for each list entry
    private let defaultDimensions: (CGFloat, CGFloat) = (500, 196)
    private let singleErrorDimensions: (CGFloat, CGFloat) = (500, 233)
    private let multiErrorDimensions: (CGFloat, CGFloat) = (500, 268)

    @State var dimensions: (CGFloat, CGFloat) = (500, 196)

    @Binding var keys: [String]
    @Binding var animate: Bool
    var addingNewAccount = false

    @State var animation: Bool = false

    var body: some View {
        Div {
            if !showLoginScreen {
                Button {
                    showBeginButton = false
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        showLoginScreen = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            showLoginScreenAnimation = true
                        }
                    }
                } label: {
                    Text("Begin")
                }
                .offset(y: showBeginButton ? 0 : 25)
                .opacity(showBeginButton ? 1 : 0)
                .animation(.easeOut(duration: 0.5), value: showBeginButton)
                .animation(.spring(duration: 0.5), value: UUID())
                .padding(5)
                .frame(height: 30)
            } else {
                Form {
                    if !showTwoStepPrompt {
                        TextField("Email", text: $email, prompt: Text("Email"))
                            .frame(minWidth: 0, maxWidth: .infinity)
                        SecureField("Password", text: $password, prompt: Text("Password"))
                            .frame(minWidth: 0, maxWidth: .infinity)
                    } else {
                        Picker("Two Step Authentication type", selection: $twoStepAuthType) {
                            ForEach(twoStepAuthTypesEnabled, id: \.self) { auth in
                                Text(auth.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .disabled(loading)
                        switch twoStepAuthType {
                        case .totp:
                            SecureField("Authenticator Code", text: $twoStepCode, prompt: Text("6 digits"))
                                .disabled(loading)
                        case .motp:
                            if !twoStepSMSSent {
                                HStack {
                                    Text("SMS Authentication Code")
                                    Spacer()
                                    Button {
                                        dimensions = defaultDimensions
                                        error = nil
                                        loading = true
                                        Task {
                                            do {
                                                twoStepPhoneNumber = try await SendOTPToPhoneNumber(using: twoStepAuthTicket)
                                                twoStepSMSSent = true
                                            } catch DFMError.shownError(let priority, let message) {
                                                self.error = (priority, message)
                                                dimensions = singleErrorDimensions
                                            } catch DFMError.thrownError(let message) {
                                                self.error = (.critical, message)
                                                dimensions = multiErrorDimensions
                                            } catch {
                                                self.error = (.critical, error.localizedDescription)
                                                dimensions = multiErrorDimensions
                                            }
                                            loading = false
                                        }
                                    } label: {
                                        Text("Send verification code")
                                    }
                                    .disabled(loading)
                                }
                            } else {
                                SecureField("SMS Authentication Code", text: $twoStepCode, prompt: Text("Enter code here"))
                                    .disabled(loading)
                            }
                        case .backup:
                            SecureField("Backup code", text: $twoStepCode, prompt: Text("8 digits"))
                                .disabled(loading)
                        }
                    }
                    Toggle(isOn: $biometricProtect) {
                        Text("Protect your login with biometrics")
                    }

                    HStack {
                        Button {
                            let url = URL(string: "https://discord.com/register")!
#if os(macOS)
                            NSWorkspace.shared.open(url)
#elseif os(iOS)
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
#endif
                        } label: {
                            Text("Create an account")
                        }
                        Button {
                            let url = URL(string: "https://discord.com/login")!
#if os(macOS)
                            NSWorkspace.shared.open(url)
#elseif os(iOS)
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
#endif
                        } label: {
                            Text("Bypass Captcha")
                        }
                        Spacer()
                        if loading {
                            ProgressView()
                                .scaleEffect(0.5)
                                .frame(width: 20, height: 20)
                        }
                        Button {
                            dimensions = defaultDimensions
                            error = nil
                            loading = true
                            if !showTwoStepPrompt {
                                Task {
                                    do {
                                        let login = try await LogInWithEmailAndPassword(with: email, password: password)

                                        if let token = login.token {
                                            var userinfo = UserDefaults.standard.object(forKey: "DFMUserInformation") as? [String: Data] ?? [String: Data]()
                                            // usually shouldn't fail
                                            let user = try await GetUser(from: token)
                                            PrintDebug(user)
                                            userinfo[email] = try DFMConstants.encoder.encode(user)
                                            UserDefaults.standard
                                                .set(userinfo, forKey: "DFMUserInformation")

                                            var userarr = UserDefaults.standard.object(forKey: "DFMUserArray") as? [[String]] ?? [[String]]()

                                            if userarr
                                                .first(where: { $0[0] == email }) != nil {
                                                throw DFMError.shownError(.info, "This account is already logged in.")
                                            }

                                            userarr.append([email, biometricProtect ? "encrypted" : ""])
                                            UserDefaults.standard
                                                .set(userarr, forKey: "DFMUserArray")
                                            DFMInformation.shared
                                                .keychainItems = userarr

                                            DFMConstants.DFMSecrets.token = token
                                            if biometricProtect {
                                                try DFMInformation.shared.keychain
                                                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: [.biometryAny])
                                                    .set(token, key: email)
                                            } else {
                                                try DFMInformation.shared.keychain.set(token, key: email)
                                            }
                                            DFMInformation.shared.loadingScreen = (true, "Initialising application")
                                            DFMInformation.shared.userInfo = nil
                                            DFMInformation.shared.guildList = nil
                                            DFMInformation.shared.error = nil
                                            DFMInformation.shared.userReferences = [:]
                                            DFMInformation.shared.privateChannels = []
                                            DFMInformation.shared.presences = []
                                            DFMInformation.shared.subscribedChannels = Set()
                                            DFMInformation.shared.messages = [:]
                                            DFMInformation.shared.liveMessages = [:]
                                            if addingNewAccount {
                                                DFMInformation.shared
                                                    .shouldAddNewAccount = (false, nil)
                                            }
                                            DFMInformation.shared
                                                .shouldShowAccountChooser = false
                                            DFMInformation.shared.gateway.start()
                                        } else {
                                            if let mfa = login.mfa, mfa {
                                                showTwoStepPrompt = true
                                            }
                                            if let totp = login.totp, totp {
                                                twoStepAuthTypesEnabled.append(.totp)
                                            }
                                            if let sms = login.sms, sms {
                                                twoStepAuthTypesEnabled.append(.motp)
                                            }
                                            if let backup = login.backup, backup {
                                                twoStepAuthTypesEnabled.append(.backup)
                                            }
                                            twoStepAuthType = twoStepAuthTypesEnabled[0]
                                            twoStepAuthTicket = login.ticket!
                                        }
                                    } catch DFMError.shownError(let priority, let message) {
                                        self.error = (priority, message)
                                        dimensions = singleErrorDimensions
                                    } catch DFMError.thrownError(let message) {
                                        self.error = (.critical, message)
                                        dimensions = multiErrorDimensions
                                    } catch {
                                        self.error = (.critical, error.localizedDescription)
                                        dimensions = multiErrorDimensions
                                    }
                                    loading = false
                                }
                            } else {
                                switch twoStepAuthType {
                                case .totp:
                                    Task {
                                        do {
                                            let token = try await LogInWithTOTP(twoStepCode, using: twoStepAuthTicket)

                                            var userinfo = UserDefaults.standard.object(forKey: "DFMUserInformation") as? [String: Data] ?? [String: Data]()
                                            // usually shouldn't fail
                                            let user: DFMUser = try await GetUser(from: token)
                                            PrintDebug(user)
                                            userinfo[email] = try DFMConstants.encoder.encode(user)
                                            UserDefaults.standard
                                                .set(userinfo, forKey: "DFMUserInformation")

                                            var userarr = UserDefaults.standard.object(forKey: "DFMUserArray") as? [[String]] ?? [[String]]()

                                            if userarr
                                                .first(where: { $0[0] == email }) != nil {
                                                throw DFMError.shownError(.info, "This account is already logged in.")
                                            }

                                            userarr.append([email, biometricProtect ? "encrypted" : ""])
                                            UserDefaults.standard
                                                .set(userarr, forKey: "DFMUserArray")
                                            DFMInformation.shared
                                                .keychainItems = userarr
                                            DFMConstants.DFMSecrets.token = token
                                            if biometricProtect {
                                                try DFMInformation.shared.keychain
                                                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: [.biometryAny])
                                                    .set(token, key: email)
                                            } else {
                                                try DFMInformation.shared.keychain.set(token, key: email)
                                            }
                                            if addingNewAccount {
                                                DFMInformation.shared
                                                    .shouldAddNewAccount = (false, nil)
                                            }
                                            DFMInformation.shared
                                                .shouldShowAccountChooser = false
                                            DFMInformation.shared.gateway.start()

                                            DFMInformation.shared.loadingScreen = (true, "Initialising application")
                                            DFMInformation.shared.userInfo = nil
                                            DFMInformation.shared.guildList = nil
                                            DFMInformation.shared.error = nil
                                            DFMInformation.shared.userReferences = [:]
                                            DFMInformation.shared.privateChannels = []
                                            DFMInformation.shared.presences = []
                                            DFMInformation.shared.subscribedChannels = Set()
                                            DFMInformation.shared.messages = [:]
                                            DFMInformation.shared.liveMessages = [:]
                                        } catch DFMError.shownError(let priority, let message) {
                                            self.error = (priority, message)
                                            dimensions = singleErrorDimensions
                                        } catch DFMError.thrownError(let message) {
                                            self.error = (.critical, message)
                                            dimensions = multiErrorDimensions
                                        } catch DFMError.internalError(let code, let priority, let message) {
                                            if code == 70 {
                                                self.error = (priority, message)
                                                dimensions = singleErrorDimensions
                                                self.showTwoStepPrompt = false
                                            }
                                        } catch {
                                            self.error = (.critical, error.localizedDescription)
                                            dimensions = multiErrorDimensions
                                        }
                                        loading = false
                                    }
                                case .motp:
                                    break
                                case .backup:
                                    break
                                }
                            }
                        } label: {
                            HStack {
                                Text("Sign In")
                            }
                        }
                        .disabled(password.isEmpty || email.isEmpty)
                        .disabled(loading)
                        .disabled(twoStepAuthType == .motp && !twoStepSMSSent)
                        .disabled(twoStepAuthType == .motp || twoStepAuthType == .backup) // temporarily, cuz i didnt implement it
                    }
                    if let error {
                        Text("\(Image(systemName: "\(error.0 == .critical ? "exclamationmark.circle.fill" : error.0 == .warning ? "exclamationmark.triangle.fill" : "info.circle.fill")")) \(error.1)")
                            .foregroundStyle(error.0 == .critical ? .red : error.0 == .warning ? .yellow : .blue)
                    }
                }
                .formStyle(.grouped)
                .frame(width: dimensions.0, height: dimensions.1)
                .cornerRadius(15)
                .offset(y: showLoginScreenAnimation ? 0 : 25)
                .opacity(showLoginScreenAnimation ? 1 : 0)
                .animation(.easeOut(duration: 0.5), value: showLoginScreenAnimation)
                .animation(.spring(duration: 0.5), value: UUID())
            }
        }
        .onAppear {
            animate = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                showBeginButton = true
            }
        }
        .frame(width: dimensions.0)
    }
}
