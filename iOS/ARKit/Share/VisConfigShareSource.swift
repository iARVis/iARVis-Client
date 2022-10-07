//
//  VisConfigShareSource.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/17.
//

import LinkPresentation

class VisConfigShareSource: NSObject, UIActivityItemSource {
    private(set) var url: URL

    init(url: URL) {
        self.url = url
    }

    private let title = "iARVis Visualization Configuration"

    func activityViewControllerPlaceholderItem(_: UIActivityViewController) -> Any {
        return url.absoluteString
    }

    func activityViewController(_: UIActivityViewController, itemForActivityType _: UIActivity.ActivityType?) -> Any? {
        return url.absoluteString
    }

    func activityViewController(_: UIActivityViewController, subjectForActivityType _: UIActivity.ActivityType?) -> String {
        return title
    }

    func squareImage(image: UIImage) -> UIImage? {
        let squareLength = max(image.size.width, image.size.height)
        let squareSize = CGSize(width: squareLength, height: squareLength)

        UIGraphicsBeginImageContextWithOptions(squareSize, false, 0.0)
        image.draw(in: CGRect(x: (squareLength - image.size.width) / 2, y: (squareLength - image.size.height) / 2, width: image.size.width, height: image.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    func activityViewControllerLinkMetadata(_: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        if let image = squareImage(image: UIImage(systemName: "chevron.left.forwardslash.chevron.right")!) {
            metadata.iconProvider = NSItemProvider(object: image)
        }
        metadata.originalURL = url
        return metadata
    }
}
