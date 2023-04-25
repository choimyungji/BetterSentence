//
//  BetterWidget.swift
//  BetterWidget
//
//  Created by Myungji Choi on 2021/02/20.
//

import WidgetKit
import SwiftUI
import Intents

struct SimpleQuoteWidgetProvider: TimelineProvider {
    typealias Entry = SimpleQuoteWidgetEntry

    func placeholder(in context: Context) -> SimpleQuoteWidgetEntry {
        SimpleQuoteWidgetEntry(date: Date(), quote: Sentence(sentence: "Hello, World!", author: "Anonymous"))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleQuoteWidgetEntry) -> ()) {
        let entry = SimpleQuoteWidgetEntry(date: Date(), quote: Sentence(sentence: "Hello, World!", author: "Anonymous"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleQuoteWidgetEntry>) -> ()) {
        var entries: [SimpleQuoteWidgetEntry] = []

        // Get a random quote from the store
        if let quote = SentenceStorage.shared.sentences.randomElement() {
            let entry = SimpleQuoteWidgetEntry(date: Date(), quote: quote)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleQuoteWidgetEntry: TimelineEntry {
    let date: Date
    let quote: Sentence
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct BetterWidgetEntryView : View {
    let sentence: Sentence
    var body: some View {
        Text(sentence.sentence)
            .font(Font.custom("NotoSerifCJKkr-Medium", size: 16))
            .padding()
            .lineSpacing(6.0)
    }
}

@main
struct BetterWidget: Widget {
    let kind: String = "BetterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SimpleQuoteWidgetProvider()) { entry in
            BetterWidgetEntryView(sentence: entry.quote)
        }
        .configurationDisplayName("Simple Quote")
        .description("Display a random quote from your app.")
        .supportedFamilies([.systemSmall])
    }
}

struct BetterWidget_Previews: PreviewProvider {
    static var previews: some View {
        BetterWidgetEntryView(sentence: Sentence(sentence: "Hello, World", author: "Maengji"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
