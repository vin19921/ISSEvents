//
//  EventsDetailView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSCommonUI
import ISSTheme
import SwiftUI
import UIKit

public struct EventsDetailView: View {

    @ObservedObject private var presenter: EventsDetailPresenter
    @State private var isRefreshing = false

    // MARK: Injection

    @Environment(\.presentationMode) var presentationMode

    init(presenter: EventsDetailPresenter) {
        self.presenter = presenter
    }

    // MARK: View

    private var statusBarHeight: CGFloat {
        let window = UIApplication.shared.connectedScenes
            .map {$0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter({ $0.isKeyWindow }).first
        
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    private var xOffset: CGFloat {
        /// All iPhone devices which are of pro max or  plus category require more offset
        /// to showcase the padding value of 16.0
        let shouldChangeOffset = UIScreen.main.bounds.width >= 414
        return shouldChangeOffset ? 20.0: 16.0
    }

    public var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: .zero) {
                ISSNavigationBarSUI(data: navigationBarData)
                
                switch presenter.state {
                case .isLoading:
                    VStack(spacing: .zero) {
                        RefreshableScrollView(showsIndicators: false, loaderOffset: 0) { refreshComplete in
                            isRefreshing = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                refreshData(completionHandler: refreshComplete)
                                refreshComplete()
                                print("refreshComplete")
                                isRefreshing = false
                            }
                        } content: {
                            VStack(spacing: 0) {
                                EventDetailHeaderView(viewData: EventDetailHeaderView.ViewData(headerImage: EventsOverviewImageAssets.test.image, title: "Example Event 1", description: "This is description of event detais\nThis is description of event detais\nThis is description of event detais\nThis is description of event detais\nThis is description of event detais\nThis is description of event detais\nThis is description of event detais", viewMoreText: "View More", viewLessText: "View Less"))

                                EventDetailSection(eventsDetailSectionTitle: "Event Details", eventDetailSection: [
                                    EventDetailCell.ViewData(title: "Saturday, 15 April 2024\n09:00:00 - 17:00:00", icon: Image(systemName: "calendar")),
                                    EventDetailCell.ViewData(title: "Duration 8hrs", icon: Image(systemName: "clock")),
                                    EventDetailCell.ViewData(title: "Register by 17:00, Sunday, 30 April 2023", icon: Image(systemName: "clock.badge.exclamationmark")),
                                    EventDetailCell.ViewData(title: "Hosted at 33, IOI Boulevard Puchong,\nBandar Puchong Jaya, Puchong", icon: Image(systemName: "location")),
                                    EventDetailCell.ViewData(title: "100 tickets left", icon: Image(systemName: "ticket")),
                                    EventDetailCell.ViewData(title: "RM 50", icon: Image(systemName: "dollarsign"))
                                ])
                                .padding([.top, .horizontal])

                                EventDetailSection(eventsDetailSectionTitle: "Speakers", eventDetailSection: [EventDetailCell.ViewData(title: "John Doe\nJohn Doe is an expert in business strategy and has authored several books on the topic\nJane Smith\nJane Smith is a renowned economist and has served on several government advisory boards")])
                                    .padding([.top, .horizontal])

                                EventDetailSection(eventsDetailSectionTitle: "Organizer", eventDetailSection: [EventDetailCell.ViewData(title: "Example Company\nContact Person\nName: Adam\nPhone: 60123456789\nEmail: booking@ibooking.com")])
                                    .padding([.top, .horizontal])
                                
                                EventDetailSection(eventsDetailSectionTitle: "Fineprint", eventDetailSection: [EventDetailCell.ViewData(title: "By registering for this event, you agree to our terms and conditions.")])
                                    .padding([.top, .horizontal])
                                
                                EventDetailSection(eventsDetailSectionTitle: "Terms and Conditions", eventDetailSection: [EventDetailCell.ViewData(title: "By registering for this event, you agree to our terms and conditions.")])
                                    .padding([.top, .horizontal])

                                EventDetailSection(eventsDetailSectionTitle: "Policy", eventDetailSection: [EventDetailCell.ViewData(title: "Refunds will not be issued after April 1, 2023.")])
                                    .padding()
                            }
                        }
                    }
                    .background(Theme.current.grayDisabled.color)
                case .failure:
                    VStack{
                        Text("Checkout Scene: Failure")
                    }
                case .success:
                    VStack{
                        Text("Checkout Scene: Success")
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .background(Theme.current.grayDisabled.color)
        }
    }

    private var navigationBarData: ISSNavigationBarBuilder.ISSNavigationBarData {
        let leftAlignedItem = ToolBarItemDataBuilder()
            .setImage(Image(systemName: "chevron.backward"))
            .setCallback {
                self.presentationMode.wrappedValue.dismiss()
            }
            .build()
        let leftAlignedSecondItem = ToolBarItemDataBuilder()
            .setTitleString("Details")
            .setTitleFont(Theme.current.subtitle.font)
            .build()
        let toolBarItems = ToolBarItemsDataBuilder()
            .setLeftAlignedItem(leftAlignedItem)
            .build()
        let issNavBarData = ISSNavigationBarBuilder()
            .setToolBarItems(toolBarItems)
            .setBackgroundColor(Theme.current.backgroundGray.color)
            .setTintColor(Theme.current.issBlack.color)
            .includeStatusBarArea(true)
            .build()
        return issNavBarData
    }

    public func setEventId(_ eventId: String) {
        presenter.setEventId(eventId)
    }
}
