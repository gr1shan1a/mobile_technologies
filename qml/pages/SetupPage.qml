import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Vocabulary.js" as Vocabulary
import "../components"
Page {
 id: page
 allowedOrientations: Orientation.All
 property bool reverse: false
property var deck
property int modeIndex: 0
property int maximum: deck ? deck.cards.length : 1
property bool validCount: /^[0-9]+$/.test(countInput.text) && Number(countInput.text) >= 1 && Number(countInput.text) <= maximum

 SilicaFlickable {
  anchors.fill: parent
  contentHeight: layout.height + Theme.paddingLarge
  Column {
   id: layout
   width: parent.width
   spacing: Theme.paddingLarge
 PageHeader { title: page.deck ? page.deck.title : "Настройка" }
Label { x: Theme.horizontalPageMargin; width: parent.width - 2*x; text: "03 / РЕЖИМ И ОБЪЁМ"; wrapMode: Text.WordWrap; font.pixelSize: Theme.fontSizeSmall; color: Theme.secondaryColor }
Repeater {
 model: Vocabulary.modes
 ChoiceButton { x: Theme.horizontalPageMargin; width: layout.width - 2*x; title: (page.modeIndex === index ? "✓  " : "") + modelData.title; subtitle: modelData.description; selected: page.modeIndex === index; onClicked: page.modeIndex = index }
}
TextField {
 id: countInput
 width: parent.width
 text: "5"
 label: "Количество карточек: от 1 до " + page.maximum
 placeholderText: "Например, 5"
 inputMethodHints: Qt.ImhDigitsOnly
 validator: IntValidator { bottom: 1; top: page.maximum }
 errorHighlight: !page.validCount
 EnterKey.onClicked: focus = false
}
Label { x: Theme.horizontalPageMargin; width: parent.width - 2*x; text: "Случайная выборка без повторов. «Повторить» вернёт сложную карточку в конец очереди."; wrapMode: Text.WordWrap; font.pixelSize: Theme.fontSizeSmall; color: Theme.secondaryColor }
Button { anchors.horizontalCenter: parent.horizontalCenter; text: "Начать тренировку"; enabled: page.validCount; onClicked: { countInput.focus = false; pageStack.push(Qt.resolvedUrl("StudyPage.qml"), {deck: page.deck, reverse: page.reverse, modeIndex: page.modeIndex, count: Number(countInput.text)}) } }
Button { anchors.horizontalCenter: parent.horizontalCenter; text: "Назад"; onClicked: pageStack.pop() }

  }
  VerticalScrollDecorator {}
 }
}
