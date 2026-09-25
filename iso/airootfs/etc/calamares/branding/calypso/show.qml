import QtQuick 2.15

Rectangle {
    anchors.fill: parent
    color: "#030705"

    Column {
        anchors.centerIn: parent
        spacing: 14

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "calypso-mark.svg"
            width: 150
            height: 150
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Installing Calypso Linux"
            color: "#9bffe0"
            font.pixelSize: 24
            font.bold: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Fast. Lean. Yours."
            color: "#8fa89d"
            font.pixelSize: 14
        }
    }
}
