//
//  TableView.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/12.
//

import SwiftUI

enum ARVisTableViewOrientation: Codable, Hashable {
    case horizontal
    case vertical
}

private struct MyDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.primary.opacity(0.3))
            .frame(height: 1)
            .padding(.vertical)
    }
}

struct ARVisTableView: View {
    @State var configuration: TableConfiguration

    var horizontalTableView: some View {
        VStack(spacing: 0) {
            let tableData = configuration.tableData
            MyDivider()
            HStack {
                ForEach(0 ..< tableData.titles.count, id: \.self) { indexTitle in
                    let title = tableData.titles[indexTitle]
                    Text(title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            Group {
                ForEach(0 ..< tableData.length, id: \.self) { index in
                    MyDivider()
                    HStack {
                        ForEach(0 ..< tableData.titles.count, id: \.self) { indexTitle in
                            let title = tableData.titles[indexTitle]
                            if let value = tableData.data[title].array?[index] {
                                Text(.init("\(value.stringValue)"))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            } else {
                                Text("-")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                }
            }
            MyDivider()
        }
    }

    var verticalTableView: some View {
        VStack(spacing: 0) {
            let tableData = configuration.tableData
            MyDivider()
            ForEach(0 ..< tableData.titles.count, id: \.self) { indexTitle in
                HStack {
                    let title = tableData.titles[indexTitle]
                    Text(title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(0 ..< tableData.length, id: \.self) { index in
                        let title = tableData.titles[indexTitle]
                        if let value = tableData.data[title].array?[index] {
                            Text(.init("\(value.stringValue)"))
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text("-")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                MyDivider()
            }
        }
    }

    var body: some View {
        Group {
            let orientation = configuration.orientation
            if orientation == .horizontal {
                horizontalTableView
            } else if orientation == .vertical {
                verticalTableView
            }
        }
    }
}
