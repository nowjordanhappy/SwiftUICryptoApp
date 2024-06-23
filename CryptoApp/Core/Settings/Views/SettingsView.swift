//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 23/06/24.
//

import SwiftUI

struct SettingsView: View {

    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://github.com/nowjordanhappy")!
    let personalCoffeeURL = URL(string: "https://www.buymeacoffee.com/nowjordanhappy")!
    let githubAvatarURL = URL(string: "https://avatars.githubusercontent.com/u/26355419?v=4")!

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                developerSection
                swiftfulThinkingSection
                coinGeckoSection
                applicationSection
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle(.settings)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        // .environment(\.locale, .init(identifier: "es"))
}

extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section(content: {
            VStack(alignment: .leading) {
                Image(.logo)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(.descriptionSwiftfulThinking)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link(.subscribeOnYouTube, destination: youtubeURL)
            Link(.supportHisCoffeeAddiction, destination: coffeeURL)
        }, header: {
            Text(.sectionSwiftfulThinking)
        })
    }

    private var coinGeckoSection: some View {
        Section(content: {
            VStack(alignment: .leading) {
                Image(.coingecko)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(.descriptionCoinGecko)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link(.visitCoinGecko, destination: coingeckoURL)
        }, header: {
            Text(.sectionCoinGecko)
        })
    }

    private var developerSection: some View {
        Section(content: {
            VStack(alignment: .leading) {
                AsyncImage(url: githubAvatarURL) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(.descriptionDeveloper)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link(.visitMyGithub, destination: personalURL)
            Link(.buyMeACoffee, destination: personalCoffeeURL)
        }, header: {
            Text(.sectionDeveloper)
        })
    }

    private var applicationSection: some View {
        Section(content: {
            Link(.termsOfService, destination: defaultURL)
            Link(.privacyPolicy, destination: defaultURL)
            Link(.companyWebsite, destination: defaultURL)
            Link(.learnMore, destination: defaultURL)
        }, header: {
            Text(.sectionApplication)
        })
    }
}
