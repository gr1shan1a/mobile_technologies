import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Vocabulary.js" as Vocabulary

Page {
    id: page
    property var deck
    property bool reverse: false
    property int modeIndex: 0
    property int count: 5
    property var queue: []
    property int position: 0
    property int remembered: 0
    property int repeats: 0
    property bool revealed: false
    property bool finished: false
    property var currentCard: position < queue.length ? queue[position] : null
    allowedOrientations: Orientation.All

    function restart() {
        queue = Vocabulary.sample(deck.cards, count)
        position = 0
        remembered = 0
        repeats = 0
        revealed = false
        finished = queue.length === 0
        flick.contentY = 0
    }

    function answer(known) {
        if (!revealed || finished)
            return
        if (known) {
            remembered++
        } else {
            var nextQueue = queue.slice(0)
            nextQueue.push(currentCard)
            queue = nextQueue
            repeats++
        }
        revealed = false
        position++
        finished = position >= queue.length
        flick.contentY = 0
    }

    Component.onCompleted: restart()

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: layout.height + Theme.paddingLarge

        Column {
            id: layout
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader { title: page.finished ? "Тренировка завершена" : page.deck.title }

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2 * x
                text: (page.reverse ? "РУССКИЙ → ENGLISH" : "ENGLISH → РУССКИЙ")
                      + "    ·    " + Vocabulary.modes[page.modeIndex].title
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeExtraSmall
                horizontalAlignment: Text.AlignHCenter
            }

            ProgressBar {
                x: Theme.horizontalPageMargin
                width: parent.width - 2 * x
                minimumValue: 0
                maximumValue: page.count
                value: Math.min(page.position, page.count)
                label: "Карточка " + Math.min(page.position + 1, page.count) + " из " + page.count
            }

            Column {
                visible: !page.finished
                width: parent.width
                spacing: Theme.paddingMedium

                Label {
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * x
                    text: Vocabulary.modes[page.modeIndex].hint
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: cardFrame
                    property bool pressed: false
                    scale: pressed ? 0.985 : 1.0
                    Behavior on scale { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * x
                    height: Math.min(350, Math.max(270, page.height * 0.39))
                    transform: Rotation {
                        origin.x: cardFrame.width / 2
                        origin.y: cardFrame.height / 2
                        axis.x: 0
                        axis.y: 1
                        axis.z: 0
                        angle: page.revealed ? 180 : 0
                        Behavior on angle {
                            NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
                        }
                    }

                    Rectangle {
                        anchors.fill: parent
                        radius: Theme.paddingLarge
                        color: Theme.rgba(Theme.highlightColor, page.revealed ? 0.16 : 0.10)
                        border.width: 2
                        border.color: Theme.rgba(Theme.highlightColor, page.revealed ? 0.65 : 0.38)
                    }

                    Column {
                        visible: !page.revealed
                        anchors.centerIn: parent
                        width: parent.width - 2 * Theme.paddingLarge
                        spacing: Theme.paddingLarge
                        Label {
                            width: parent.width
                            text: page.reverse ? "РУССКИЙ" : "ENGLISH"
                            color: Theme.secondaryColor
                            font.pixelSize: Theme.fontSizeExtraSmall
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Label {
                            width: parent.width
                            text: Vocabulary.question(page.currentCard, page.reverse)
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeExtraLarge
                            font.bold: true
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Label {
                            width: parent.width
                            text: "Нажмите на карточку, чтобы перевернуть"
                            color: Theme.secondaryColor
                            font.pixelSize: Theme.fontSizeExtraSmall
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Column {
                        id: cardBack
                        visible: page.revealed
                        anchors.centerIn: parent
                        width: parent.width - 2 * Theme.paddingLarge
                        spacing: Theme.paddingMedium
                        transform: Rotation {
                            origin.x: cardBack.width / 2
                            origin.y: cardBack.height / 2
                            axis.x: 0
                            axis.y: 1
                            axis.z: 0
                            angle: 180
                        }
                        Label {
                            width: parent.width
                            text: page.reverse ? "ENGLISH" : "РУССКИЙ"
                            color: Theme.secondaryColor
                            font.pixelSize: Theme.fontSizeExtraSmall
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Label {
                            width: parent.width
                            text: Vocabulary.answer(page.currentCard, page.reverse)
                            color: Theme.highlightColor
                            font.pixelSize: Theme.fontSizeLarge
                            font.bold: true
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Rectangle {
                            width: parent.width * 0.35
                            height: 2
                            color: Theme.rgba(Theme.highlightColor, 0.45)
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Label {
                            width: parent.width
                            text: page.currentCard ? page.currentCard.example : ""
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeSmall
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Label {
                            width: parent.width
                            text: "Нажмите ещё раз, чтобы увидеть слово"
                            color: Theme.secondaryColor
                            font.pixelSize: Theme.fontSizeExtraSmall
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: cardFrame.pressed = true
                        onReleased: cardFrame.pressed = false
                        onCanceled: cardFrame.pressed = false
                        onClicked: page.revealed = !page.revealed
                    }
                }

                Label {
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * x
                    text: "Карточку можно переворачивать сколько угодно раз."
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    horizontalAlignment: Text.AlignHCenter
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Помню — следующая"
                    enabled: page.revealed
                    onClicked: page.answer(true)
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Повторить позже"
                    visible: page.revealed
                    onClicked: page.answer(false)
                }
            }

            Column {
                visible: page.finished
                width: parent.width
                spacing: Theme.paddingLarge
                Label {
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * x
                    text: "Вы прошли " + page.remembered + " из " + page.count + " карточек.\nОтправлено на повторение: " + page.repeats + "."
                    font.pixelSize: Theme.fontSizeLarge
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }
                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Новая подборка"
                    onClicked: page.restart()
                }
                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "К настройкам"
                    onClicked: pageStack.pop()
                }
            }
        }
        VerticalScrollDecorator {}
    }
}
