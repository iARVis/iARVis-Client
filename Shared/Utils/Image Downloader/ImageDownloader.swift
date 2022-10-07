//
//  ImageDownloader.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/31.
//

import Foundation
import Kingfisher

class TaskCache {
    var taskCache: [URL: DownloadTask] = [:]
    private var sequenceQueue = DispatchQueue(label: "TaskCacheQueue")

    func cancel(url: URL) {
        sequenceQueue.sync {
            taskCache[url]?.cancel()
            taskCache[url] = nil
        }
    }

    func start(url: URL, task: DownloadTask?) {
        guard let task = task else { return }
        cancel(url: url)
        sequenceQueue.sync {
            taskCache[url] = task
        }
    }
}

class ImageDownloader {
    private var taskCache = TaskCache()

    static let `default` = ImageDownloader()

    func download(url: URL) async throws -> KFCrossPlatformImage {
        return try await withTaskCancellationHandler(handler: {
            taskCache.cancel(url: url)
        }, operation: {
            // Check cancellation first because cancellation handler could be called before the operation starts.
            try Task.checkCancellation()
            return try await withCheckedThrowingContinuation { continuation in
                // Needed because Kingfisher can in some cases incorrectly call the completion handler multiple times.
                var hasBeenCalled = false
                taskCache.start(url: url, task:
                    KingfisherManager.shared.retrieveImage(with: url) { result in
                        guard !hasBeenCalled else {
                            return
                        }
                        hasBeenCalled = true

                        switch result {
                        case let .success(value):
                            continuation.resume(with: Result.success(value.image))
                        case let .failure(error):
                            continuation.resume(throwing: error)
                        }
                    })
            }
        })
    }
}
