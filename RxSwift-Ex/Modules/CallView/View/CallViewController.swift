//
//  CallViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 22.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import SVProgressHUD

import RxSwift
import RxCocoa
import RxBinding

import VoxImplantSDK
import CallKit

final class CallViewController: UIViewController, CallManager {
    private(set) var activeCall: CallDescriptor? = nil
    private(set) var registeredCalls: [UUID: CallDescriptor]! = [:]
    private(set) var pendingCall: CallDescriptor? = nil
    
    private var startCallAction: CXStartCallAction?
    
    func call(uuid: UUID!) -> CallDescriptor? {
        registeredCalls[uuid]
    }
    
    func call(call: VICall!) -> CallDescriptor? {
        for (_, descriptor) in self.registeredCalls {
            if descriptor.call == call {
                return descriptor
            }
        }
        return nil
    }
    
    func registerCall(_ descriptor: CallDescriptor!) {
        self.registeredCalls[descriptor.uuid] = descriptor

        if descriptor.incoming {
            let callinfo = CXCallUpdate()
            var userName = "Unknown caller";
            if let userDisplayName = descriptor.call!.endpoints.first!.userDisplayName {
                userName = userDisplayName
            }
            callinfo.remoteHandle = CXHandle(type: .generic, value: userName)
            callinfo.supportsHolding = false
            callinfo.supportsGrouping = false
            callinfo.supportsUngrouping = false
            callinfo.supportsDTMF = true
            callinfo.hasVideo = descriptor.withVideo
            callinfo.localizedCallerName = userName

            callProvider.reportNewIncomingCall(with: descriptor.uuid, update: callinfo) { [weak self] error in
                guard error == nil else {
                    print(error ?? "")
                    self?.endCall(descriptor)
                    return
                }
            }
        } else {
            let handle = CXHandle(type: .generic, value: "")
            let startAction = CXStartCallAction(call: descriptor.uuid, handle: handle)
            startAction.isVideo = descriptor.withVideo
            let transaction = CXTransaction(action: startAction)
            requestTransaction(transaction)
        }
    }
    
    func startCall(_ descriptor: CallDescriptor!) {
        descriptor.started = true
        self.activeCall = descriptor
    }
    
    func endCall(_ descriptor: CallDescriptor!) {
        if self.activeCall?.uuid == descriptor.uuid {
            self.activeCall = nil
        }

        let endTransaction = CXEndCallAction(call: descriptor.uuid)
        let transaction = CXTransaction(action: endTransaction)
        requestTransaction(transaction)
    }
    
    private func requestTransaction(_ transaction: CXTransaction!) {
        callController.request(transaction) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    private func reconnect(client: VIClient) {
        self.client = client
        
        guard
            let loginAction = self.loginAction,
            let contactUsername = self.contactUsernameLabel.text else { return }
        
        loginAction()
        let callSettings = VICallSettings()
        callSettings.videoFlags = VIVideoFlags.videoFlags(receiveVideo: true, sendVideo: true)

        if let call = client.call("\(contactUsername).voximpant.com", settings: callSettings) {
            call.start()
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contactUsernameLabel: UITextField!
    @IBOutlet private weak var callButton: UIButton!
    
    var client: VIClient?
    var loginAction: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private let callController = CXCallController()
    private let callProvider: CXProvider = {
        let providerConfiguration = CXProviderConfiguration(localizedName: "VideoCallKit")
        providerConfiguration.supportsVideo = false
        providerConfiguration.maximumCallsPerCallGroup = 1
        providerConfiguration.supportedHandleTypes = [.generic]
        providerConfiguration.ringtoneSound = "noisecollector-beam.aiff"
        
        return CXProvider(configuration: providerConfiguration)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callProvider.setDelegate(self, queue: DispatchQueue.main)
        
        client?.sessionDelegate = self
        client?.callManagerDelegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.kbrMainPink]
        
        callButton.layer.cornerRadius = callButton.frame.height / 2
        
        func bind() {
            callButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    guard
                        let self = self,
                        let client = self.client,
                        let contactUsername = self.contactUsernameLabel.text else { return }
                    
                    if client.clientState == .disconnected {
                        SVProgressHUD.show()
                        client.connect()
                        return
                    }
                    
                    let callSettings = VICallSettings()
                    callSettings.videoFlags = VIVideoFlags.videoFlags(receiveVideo: true, sendVideo: true)

                    if let call = client.call("\(contactUsername).voximpant.com", settings: callSettings) {
                        call.start()
                    }
                })
                .disposed(by: disposeBag)
        }
        
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        client?.disconnect()
        
        navigationController?.navigationItem.title = "Login"
    }
    
    private func startReceiveCall(with descriptor: CallDescriptor) {
        //let descriptor = CallDescriptor(call: call, uuid: UUID(), video: video, incoming: true)
        registerCall(descriptor)
        descriptor.call.add(self)
        descriptor.call.endpoints.first?.delegate = self
        
        VIAudioManager.shared().select(VIAudioDevice(type: .speaker))
    }
}

//MARK: VIClientCallManagerDelegate
extension CallViewController: VIClientCallManagerDelegate {
    func client(_ client: VIClient, didReceiveIncomingCall call: VICall, withIncomingVideo video: Bool, headers: [AnyHashable : Any]?) {
        startReceiveCall(with: .init(call: call, uuid: UUID(), video: video, incoming: true))
    }
}

extension CallViewController: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
        print("")
    }

    func providerDidBegin(_ provider: CXProvider) {
        print("")
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        guard let descriptor = call(uuid: action.callUUID) else {
            action.fail()
            return
        }

        VIAudioManager.shared().callKitConfigureAudioSession(nil)
        let settings = VICallSettings()
        settings.videoFlags = VIVideoFlags.videoFlags(receiveVideo: descriptor.withVideo, sendVideo: descriptor.withVideo)
        settings.customData = "Voximplant swift demo"
        settings.preferredVideoCodec = Settings.shared.preferredCodec
        descriptor.call.answer(with: settings)
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        guard let descriptor = call(uuid: action.callUUID) else {
            action.fail()
            return
        }
        descriptor.call.add(self)
        callProvider.reportOutgoingCall(with: action.callUUID, startedConnectingAt: Date())

        VIAudioManager.shared().callKitConfigureAudioSession(nil)

        startCallAction = action
        descriptor.call.start()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        guard let descriptor = call(uuid: action.callUUID) else {
            action.fail()
            return
        }

        VIAudioManager.shared().callKitStopAudio()
        VIAudioManager.shared().callKitReleaseAudioSession()

        descriptor.call.hangup(withHeaders: nil)
        action.fulfill(withDateEnded: Date())

        registeredCalls.removeValue(forKey: descriptor.uuid)
    }

    func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
        guard let descriptor = call(uuid: action.callUUID) else {
            action.fail()
            return
        }

        descriptor.call.setHold(!action.isOnHold) { error in
            guard error == nil else {
                print(error ?? "")
                action.fail()
                return
            }

            action.fulfill()
        }
    }

    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
        guard let descriptor = call(uuid: action.callUUID) else {
            action.fail()
            return
        }

        descriptor.call.sendAudio = !action.isMuted

        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXPlayDTMFCallAction) {
        guard let descriptor = call(uuid: action.callUUID) else {
            action.fail()
            return
        }

        descriptor.call.sendDTMF(action.digits)
        action.fulfill()
    }

    func provider(_ provider: CXProvider, timedOutPerforming action: CXAction) {
        print("timedOutPerforming")
    }

    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        VIAudioManager.shared().callKitStartAudio()
    }

    func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        VIAudioManager.shared().callKitStopAudio()
    }
}

extension CallViewController: VICallDelegate {
    func call(_ call: VICall, didFailWithError error: Error, headers: [AnyHashable: Any]?) {
        if let descriptor = self.call(call: call) {
            callProvider.reportCall(with: descriptor.uuid, endedAt: Date(), reason: .failed)
        }

        if let action = self.startCallAction {
            action.fail()
            startCallAction = nil
        }
    }

    func call(_ call: VICall, didConnectWithHeaders headers: [AnyHashable: Any]?) {
        if let descriptor = self.call(call: call) {
            callProvider.reportOutgoingCall(with: descriptor.uuid, connectedAt: Date())

            if let userName = call.endpoints.first?.userDisplayName {
                let update = CXCallUpdate()
                let handle = CXHandle(type: .generic, value: userName)
                update.remoteHandle = handle

                self.callProvider.reportCall(with: descriptor.uuid, updated: update)
            }
        }

        if let action = startCallAction {
            action.fulfill(withDateStarted: Date())
            startCallAction = nil
        }
    }

    func call(_ call: VICall, didDisconnectWithHeaders headers: [AnyHashable: Any]?, answeredElsewhere: NSNumber) {
        if let descriptor = self.call(call: call) {
            endCall(descriptor)
        }
    }
}

extension CallViewController: VIEndpointDelegate {
    func endpoint(_ endpoint: VIEndpoint, didAddRemoteVideoStream videoStream: VIVideoStream) {
        print("didAddRemoteVideoStream: \(endpoint.endpointId) \(endpoint.userDisplayName ?? "") \(String(describing: videoStream.streamId))")
    }
}

extension CallViewController: VIClientSessionDelegate {
    func clientSessionDidConnect(_ client: VIClient) {
        reconnect(client: client)
    }
    
    func clientSessionDidDisconnect(_ client: VIClient) {
        print("Client did disconnect")
    }
    
    func client(_ client: VIClient, sessionDidFailConnectWithError error: Error) {
        print("Client did fail connect")
    }
}
