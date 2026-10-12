import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    objectName: "defaultCover"

    CoverTemplate {
        objectName: "applicationCover"
        primaryText: "VocExtender"
        secondaryText: "Английские карточки"
        icon {
            source: Qt.resolvedUrl("../icons/VocExtender.svg")
            sourceSize { width: icon.width; height: icon.height }
        }
    }
}
