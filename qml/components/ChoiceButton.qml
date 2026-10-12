import QtQuick 2.0
import Sailfish.Silica 1.0
BackgroundItem {
    id: control
    property string title
    property string subtitle
    property bool selected: false
    height: Math.max(Theme.itemSizeLarge, labels.height + 2 * Theme.paddingLarge)
    Rectangle {
        anchors.fill: parent
        radius: Theme.paddingMedium
        color: control.down ? Theme.rgba(Theme.highlightColor, 0.24) : Theme.rgba(Theme.highlightColor, control.selected ? 0.18 : 0.07)
        border.width: control.selected ? 2 : 1
        border.color: Theme.rgba(Theme.highlightColor, control.selected ? 0.75 : 0.3)
    }
    Column {
        id: labels
        x: Theme.paddingLarge
        width: parent.width - 2 * x
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.paddingSmall
        Label { width: parent.width; text: control.title; font.pixelSize: Theme.fontSizeMedium; font.bold: true; color: Theme.primaryColor; wrapMode: Text.WordWrap }
        Label { width: parent.width; visible: text.length > 0; text: control.subtitle; font.pixelSize: Theme.fontSizeExtraSmall; color: Theme.secondaryColor; wrapMode: Text.WordWrap }
    }
}
