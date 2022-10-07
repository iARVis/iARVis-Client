//
//  ARKitViewController.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/28.
//

import ARKit
import Combine
import SnapKit
import SwiftUI
import UIKit

class ARKitViewController: UIViewController {
    var visContext = VisualizationContext()

    let trackingSwitch = UISwitch()
    let trackingLabel = UILabel()

    override func loadView() {
        view = ARSCNView()
    }

    var sceneView: ARSCNView {
        view as! ARSCNView
    }

    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        sceneView.session
    }

    var focusedWidgetNode: CurrentValueSubject<SCNWidgetNode?, Never> = .init(nil)
    var focusedChartConfiguration: CurrentValueSubject<ChartConfiguration?, Never> = .init(nil)
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Hot reload

    private var hotReloadCenter: HotReloadCenter!

    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.session.delegate = self

        // Debug
        trackingLabel.text = "Tracking: "
        trackingSwitch.isOn = true
        view.addSubview(trackingLabel)
        view.addSubview(trackingSwitch)
        trackingLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        trackingSwitch.snp.makeConstraints { make in
            make.leading.equalTo(trackingLabel.snp.trailing)
            make.centerY.equalTo(trackingLabel)
        }

        setUpSupplementaryViews()
        setUpDebugView()

        // Hot reload
        hotReloadCenter = .init(config: .init(), isChanged: { newValue in
            newValue != self.visContext.visConfiguration
        }, didUpdate: { newValue in
            DispatchQueue.main.async {
                if UIApplication.shared.topController() == self {
                    let alertController = UIAlertController(title: "Update", message: "A new visualization configuration is detected, would you like to update now?", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Update", style: .destructive, handler: { action in
                        self.setVisualizationConfiguration(newValue)
                    }))
                    alertController.addAction(UIAlertAction(title: "Later", style: .cancel, handler: { _ in }))
                    UIApplication.shared.presentOnTop(alertController, animated: true)
                }
            }
        })

        setUpSettingView()

        // set VisualizationConfiguration
        setVisualizationConfiguration(.example1)
        printDebug(VisualizationConfiguration.example1.prettyJSON)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Prevent the screen from being dimmed to avoid interrupting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
    }

    // MARK: - Set Up Views

    private func setUpSupplementaryViews() {
        // Share button
        var _shareButtonViewController: UIViewController?
        let shareButtonViewController = vibrantButton(systemImage: "square.and.arrow.up") { [weak self] in
            guard let self = self, let shareButtonViewController = _shareButtonViewController else { return }
            if let visConfigJSONString = self.visContext.visConfiguration?.prettyJSON,
//               let url = URL(string: "https://google.com") {
               let url = URL(string: URLService.openVisConfig(config: .json(json: visConfigJSONString)).url) {
                printDebug(url)
                let activityViewController = UIActivityViewController(activityItems: [VisConfigShareSource(url: url)], applicationActivities: nil)
                activityViewController.title = "Share Your Visualization Configuration"

                activityViewController.popoverPresentationController?.sourceView = shareButtonViewController.view
                activityViewController.popoverPresentationController?.sourceRect = shareButtonViewController.view.frame
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
        _shareButtonViewController = shareButtonViewController
        addChildViewController(shareButtonViewController)
        shareButtonViewController.view.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        if #available(iOS 16, *) {
            // Transform Control View
            let transformControlViewController = TransformControlViewController()
            addChildViewController(transformControlViewController)
            transformControlViewController.view.alpha = 0.0

            let transformControlButtonViewController = vibrantButton(systemImage: "move.3d") {
                UIView.animate(withDuration: 0.5) {
                    transformControlViewController.view.alpha = 1 - transformControlViewController.view.alpha
                }
            }
            addChildViewController(transformControlButtonViewController)

            transformControlButtonViewController.view.snp.makeConstraints { make in
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
            transformControlViewController.view.snp.makeConstraints { make in
                make.bottom.equalTo(transformControlButtonViewController.view.snp.top).offset(-8)
                make.trailing.equalTo(transformControlButtonViewController.view)
            }

            // Chart Configuration Setting View
            let chartConfigurationSettingViewController = ChartConfigurationSettingViewController()
            addChildViewController(chartConfigurationSettingViewController)
            chartConfigurationSettingViewController.view.alpha = 0

            let chartConfigurationSettingButtonViewController = vibrantButton(systemImage: "chart.xyaxis.line") {
                UIView.animate(withDuration: 0.5) {
                    chartConfigurationSettingViewController.view.alpha = 1 - chartConfigurationSettingViewController.view.alpha
                }
            }
            addChildViewController(chartConfigurationSettingButtonViewController)

            chartConfigurationSettingButtonViewController.view.snp.makeConstraints { make in
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            }
            chartConfigurationSettingViewController.view.snp.makeConstraints { make in
                make.top.equalTo(chartConfigurationSettingButtonViewController.view.snp.bottom).offset(8)
                make.trailing.equalTo(chartConfigurationSettingButtonViewController.view)
            }

            focusedWidgetNode.sink { widgetNode in
                if let widgetConfiguration = widgetNode?.widgetConfiguration {
                    UIView.animate(withDuration: 0.5) {
                        transformControlButtonViewController.view.alpha = 1
                    }
                    transformControlButtonViewController.view.isUserInteractionEnabled = true
                    transformControlViewController.update(widgetConfiguration: widgetConfiguration)
                } else {
                    UIView.animate(withDuration: 0.5) {
                        transformControlButtonViewController.view.alpha = 0
                        transformControlButtonViewController.view.alpha = 0
                    }
                    transformControlButtonViewController.view.isUserInteractionEnabled = false
                }
            }
            .store(in: &subscriptions)

            focusedChartConfiguration.sink { chartConfiguration in
                if let chartConfiguration = chartConfiguration {
                    UIView.animate(withDuration: 0.5) {
                        chartConfigurationSettingButtonViewController.view.alpha = 1
                    }
                    chartConfigurationSettingButtonViewController.view.isUserInteractionEnabled = true
                    chartConfigurationSettingViewController.update(chartConfiguration: chartConfiguration)
                } else {
                    UIView.animate(withDuration: 0.5) {
                        chartConfigurationSettingButtonViewController.view.alpha = 0
                        chartConfigurationSettingViewController.view.alpha = 0
                    }
                    chartConfigurationSettingButtonViewController.view.isUserInteractionEnabled = false
                }
            }
            .store(in: &subscriptions)
        }
    }

    private func setUpSettingView() {
        let doubleTapGesture = UITapGestureRecognizerWithClosure { [weak self] _ in
            guard let self = self else { return }
            let settingViewController = SettingViewController(hotReloadConfiguration: self.hotReloadCenter.config)
            settingViewController.modalPresentationStyle = .fullScreen
            UIApplication.shared.presentOnTop(settingViewController)
        }
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 3
        view.addGestureRecognizer(doubleTapGesture)
    }

    private func setUpDebugView() {
        let doubleTapGesture = UITapGestureRecognizerWithClosure { _ in
            var viewController: UIViewController?
            let debugViewController = VisConfigDebugExampleListViewController { [weak self] config in
                guard let self = self else { return }
                self.setVisualizationConfiguration(config)
                viewController?.dismiss(animated: true)
            }
            viewController = debugViewController
            UIApplication.shared.presentOnTop(debugViewController)
        }
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
    }

    // MARK: - Session management

    private func generateConfiguration(trackedImages: [ARReferenceImage] = [], trackedObjects: [ARReferenceObject] = []) -> ARConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        // Image tracking
        let referenceImages = Set(trackedImages)
        configuration.detectionImages = referenceImages
        // Enable auto scale estimation. But, DO NOT change the image size during tracking!
        configuration.automaticImageScaleEstimationEnabled = true
        configuration.maximumNumberOfTrackedImages = referenceImages.count

        // Object tracking
        configuration.detectionObjects = Set(trackedObjects)
        return configuration
    }

    /// Creates a new AR configuration to run on the `session`.
    func resetTracking(trackedImages: [ARReferenceImage] = [], trackedObjects: [ARReferenceObject] = []) {
        let configuration = generateConfiguration(trackedImages: trackedImages, trackedObjects: trackedObjects)
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

// MARK: - Visualization Configuration

extension ARKitViewController {
    func setVisualizationConfiguration(_ conf: VisualizationConfiguration) {
        sceneView.scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        resetTracking()
        visContext.reset()
        focusedWidgetNode.send(nil)
        focusedChartConfiguration.send(nil)

        visContext.visConfiguration = conf
        visContext.processVisualizationConfiguration { [weak self] result in
            if let self = self {
                DispatchQueue.main.async {
                    self.resetTracking(trackedImages: result.referenceImages, trackedObjects: result.referenceObjects)
                }
            }
        }
    }
}
