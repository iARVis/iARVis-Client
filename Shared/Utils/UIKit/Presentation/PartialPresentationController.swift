//
//  PartialPresentationController.swift
//  PartialViewControllerSample
//
//  Created by Anonymous on 2021/11/16.
//

import UIKit

public final class PartialPresentationController: UIPresentationController {
    // MARK: Constants

    public enum Direction {
        case top
        case bottom
        case left
        case right
        case center

        var swipeDirection: UISwipeGestureRecognizer.Direction {
            switch self {
            case .top: return .up
            case .bottom: return .down
            case .left: return .left
            case .right: return .right
            case .center: return .down
            }
        }
    }

    public enum SizeType {
        case full
        case fit
        case absolute(CGFloat)
        case proportion(CGFloat)
    }

    public typealias SizePair = (width: SizeType, height: SizeType)

    // MARK: Properties

    private let direction: Direction

    private let viewSize: SizePair

    private var contentSize: CGSize = .zero

    private let isSwipeEnabled: Bool

    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapBackground))
    private var swipeRecognizer: UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwiped))
        swipe.direction = direction.swipeDirection
        return swipe
    }

    private lazy var dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.backgroundColor = .black.withAlphaComponent(0.52)
        dimmingView.alpha = 0
        dimmingView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        dimmingView.addGestureRecognizer(tapRecognizer)
        if isSwipeEnabled {
            dimmingView.addGestureRecognizer(swipeRecognizer)
        }
        return dimmingView
    }()

    // MARK: Initialize

    init(
        direction: Direction,
        viewSize: SizePair,
        isSwipeEnabled: Bool = true,
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        presentedViewController.modalPresentationStyle = .custom
        presentedViewController.modalTransitionStyle = .crossDissolve
        self.direction = direction
        self.viewSize = viewSize
        self.isSwipeEnabled = isSwipeEnabled
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    /// present 애니메이션
    override public func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        containerView?.addSubview(dimmingView)
        dimmingView.frame.size = containerView?.bounds.size ?? .zero

        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 1

            let transform: CGAffineTransform
            switch self?.direction {
            case .top:
                transform = .init(translationX: 0, y: self?.presentedView?.frame.height ?? 0)
            case .bottom:
                transform = .init(translationX: 0, y: -(self?.presentedView?.frame.height ?? 0))
            case .left:
                transform = .init(translationX: self?.presentedView?.frame.width ?? 0, y: 0)
            case .right:
                transform = .init(translationX: -(self?.presentedView?.frame.width ?? 0), y: 0)
            case .center:
                let presentedViewHeight = self?.presentedView?.frame.height ?? 0
                let containerViewHeight = self?.containerView?.frame.height ?? 0
                transform = .init(translationX: 0, y: -(containerViewHeight / 2 + presentedViewHeight / 2))
            case .none:
                transform = .identity
            }
            self?.presentedView?.transform = transform
        }, completion: nil)

        // swipe to dismiss
        if isSwipeEnabled {
            presentedView?.addGestureRecognizer(swipeRecognizer)
        }
        presentedView?.clipsToBounds = true
        presentedView?.layer.cornerCurve = .continuous
        presentedView?.layer.cornerRadius = 12
    }

    override public func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.dimmingView.alpha = 0
            self?.presentedView?.transform = .identity
            if context.transitionDuration <= 0 {
                self?.dimmingView.removeFromSuperview()
            }
        }, completion: { [weak self] _ in
            self?.dimmingView.removeFromSuperview()
        })
    }

    override public var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView,
              let presentedView = presentedView else { return .zero }

        let compressedSize = presentedView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .defaultLow,
            verticalFittingPriority: .defaultLow
        )

        var frame = containerView.bounds

        switch viewSize.width {
        case .full:
            frame.size.width = frame.width
        case .fit:
            frame.size.width = compressedSize.width
        case let .absolute(value):
            frame.size.width = value
        case let .proportion(proportion):
            frame.size.width = frame.width * max(0, min(1, proportion))
        }

        switch viewSize.height {
        case .full:
            frame.size.height = frame.height
        case .fit:
            frame.size.height = compressedSize.height
        case let .absolute(value):
            frame.size.height = value
        case let .proportion(proportion):
            frame.size.height = frame.height * max(0, min(1, proportion))
        }

        if case .fit = viewSize.width {
            let temp = CGSize(width: UIView.layoutFittingCompressedSize.width, height: frame.size.height)
            frame.size.width = presentedView.systemLayoutSizeFitting(temp, withHorizontalFittingPriority: .defaultLow, verticalFittingPriority: .required).width
        }
        if case .fit = viewSize.height {
            let temp = CGSize(width: frame.size.width, height: UIView.layoutFittingCompressedSize.height)
            frame.size.height = presentedView.systemLayoutSizeFitting(temp, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow).height
        }

        switch direction {
        case .top:
            frame.origin.y = 0 - frame.height
            frame.origin.x = (containerView.bounds.width - frame.width) / 2
        case .bottom:
            frame.origin.y = containerView.bounds.height - frame.height + frame.height
            frame.origin.x = (containerView.bounds.width - frame.width) / 2
        case .left:
            frame.origin.x = 0 - frame.width
            frame.origin.y = (containerView.bounds.height - frame.height) / 2
        case .right:
            frame.origin.x = containerView.bounds.width - frame.width + frame.width
            frame.origin.y = (containerView.bounds.height - frame.height) / 2
        case .center:
            frame.origin.x = containerView.center.x - frame.width / 2
            frame.origin.y = containerView.bounds.height
        }

        return frame
    }

    // tap background to dismiss
    @objc private func onTapBackground() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }

    // swipe to dismiss
    @objc private func onSwiped() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
