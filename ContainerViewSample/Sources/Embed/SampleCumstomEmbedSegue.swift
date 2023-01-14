//
//  SampleCumstomEmbedSegue.swift
//  ContainerViewSample
//
//  Created by Ysk.Manabe on 2023/01/14.
//

import UIKit

final class SampleCumstomEmbedSegue: UIEmbedSegue {

    override func perform() {

        guard let container = self.container else {
            return
        }

        source.willMove(toParent: nil)
        container.addChild(destination)

        destination.view.frame = .zero

        container.transition(from: source,
                        to: destination,
                        duration: 0.3) {
            self.destination.view.frame = container.view.bounds
            self.source.view.frame = .zero
        } completion: { finished in
            self.source.removeFromParent()
            self.destination.didMove(toParent: container)
        }

    }

}
