//
//  EventDetailHeaderView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct EventDetailHeaderView: View {

    // MARK: - View Dependencies

    let viewData: ViewData

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerImage
            titleDescriptionView

            HStack(spacing: 12) {
                FavouriteButton(buttonData: FavouriteButtonData(isSaved: false))
                shareButton
            }
            .padding(.top, 32)
            .padding([.leading, .trailing], 16)
        }
    }
}

// MARK: - View Components

private extension EventDetailHeaderView {
    var headerImage: some View {
        GeometryReader { geometry in
            EventsOverviewImageAssets.test.image
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(height: 375)
    }

    var titleDescriptionView: some View {
        TitleDescriptionSUIView(viewData: titleDescriptionSUIViewData)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 24)
            .padding([.leading, .trailing], 16)
    }

    var shareButton: some View {
        RoundedImageButton(height: 40, image: Image(systemName: "square.and.arrow.up")) {}
    }
}

extension EventDetailHeaderView {
    final class FavouriteButtonData: ObservableObject {
        @Published var isSaved: Bool

        init(isSaved: Bool) {
            self.isSaved = isSaved
        }
    }

    struct FavouriteButton: View {
        @ObservedObject var buttonData: FavouriteButtonData

        var body: some View {
            let image: Image = buttonData.isSaved ? Image(systemName: "heart.fill") : Image(systemName: "heart")
            return RoundedImageButton(height: 40, image: image) {
                buttonData.isSaved.toggle()
            }
        }
    }
}

// MARK: - Nested types

extension EventDetailHeaderView {
    struct ViewData {
        let headerImage: Image
        let title: String
        let description: String
        let viewMoreText: String
        let viewLessText: String
    }

    enum Action {
        case favourite(isSaved: Bool)
    }
}

// MARK: - Private

private extension EventDetailHeaderView {
    var titleDescriptionSUIViewData: TitleDescriptionSUIView.ViewData {
        TitleDescriptionSUIView.ViewData(title: viewData.title,
                                         description: viewData.description,
                                         viewMoreText: viewData.viewMoreText,
                                         viewLessText: viewData.viewLessText)
    }
}

private extension EventDetailHeaderView {
    enum EventDetailHeaderViewImageAssets: String, ImageLoaderSUI {
        case favourite
        case unfavourite
    }
}

