#!/bin/zsh


() {
    filename=/tmp/${argv[0]}-${argv:t}-$$
    swiftc $1 -o $filename
    ./$filename
} =(cat <<EOF
import os
import OSLog

public struct Constants {
    static let text = CommandLine.arguments[1]
    static let subsystem = "com.maximpuchkov.zterm"
    static let category = "zsh"
    static log = OSLog(subsystem: subsystem,
                       category: category)
}


print(Constants.subsystem)

EOF
)
