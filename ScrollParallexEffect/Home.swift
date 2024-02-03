//
//  Home.swift
//  ScrollParallexEffect
//
//  Created by Amish Tufail on 02/02/2024.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15.0) {
                dummySection(title: "Social Media")
                dummySection(title: "Sales", isLong: true)
                // Parallax Image
                ParallaxImageView(maximumMovement: 150.0,useFullWidth: true) { size in
                    Image(.imageOne)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 300.0)
                dummySection(title: "Social Media")
                dummySection(title: "Sales", isLong: true)
                ParallaxImageView(useFullWidth: true) { size in
                    Image(.imageTwo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 400.0)
                dummySection(title: "Social Media")
                dummySection(title: "Sales", isLong: true)
                ParallaxImageView(useFullWidth: true) { size in
                    Image(.imageThree)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 400.0)
                dummySection(title: "Social Media")
                dummySection(title: "Sales", isLong: true)
                ParallaxImageView(useFullWidth: true) { size in
                    Image(.imageTwo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 500.0)
                dummySection(title: "Social Media")
                dummySection(title: "Sales", isLong: true)
                ParallaxImageView(useFullWidth: true) { size in
                    Image(.imageThree)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 500.0)
                dummySection(title: "Social Media")
                dummySection(title: "Sales", isLong: true)
            }
            .padding(15.0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension Home {
    @ViewBuilder
    func dummySection(title: String, isLong: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(title)
                .font(.title.bold())
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. \(isLong ? "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English." : "")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipped()
    }
}

struct ParallaxImageView<Content: View>: View {
    var maximumMovement: CGFloat = 100
    var useFullWidth: Bool = false
    @ViewBuilder var content: (CGSize) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
            // Movement animation properties
            let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
            let scrollViewHeight = $0.bounds(of: .scrollView)?.size.height ?? 0
            let maximumMovement = min(maximumMovement, (size.height * 0.35))
            let strechtedSize: CGSize = .init(width: size.width, height: size.height + maximumMovement)
            
            let progress = minY / scrollViewHeight
            let cappedProgress = max(min(progress,1.0), -1.0)
            let movementOffset = cappedProgress * -maximumMovement
            
            content(size)
                .offset(y: movementOffset)
                .frame(width: strechtedSize.width, height: strechtedSize.height)
                .frame(width: size.width, height: size.height)
                .clipped()
        }
        .containerRelativeFrame(useFullWidth ? [.horizontal] : [])
    }
}

#Preview {
    ContentView()
}
