import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Vocabulary.js" as Vocabulary
import "../components"
Page {
 id: page
 allowedOrientations: Orientation.All
 property bool reverse: false
 SilicaFlickable {
  anchors.fill: parent
  contentHeight: layout.height + Theme.paddingLarge
  Column {
   id: layout
   width: parent.width
   spacing: Theme.paddingLarge
 PageHeader { title: "Тема тренировки" }
Label { x: Theme.horizontalPageMargin; width: parent.width - 2*x; text: "02 / ТЕМА"; wrapMode: Text.WordWrap; font.pixelSize: Theme.fontSizeSmall; color: Theme.secondaryColor }
Label { x: Theme.horizontalPageMargin; text: page.reverse ? "Русский → English" : "English → Русский"; color: Theme.highlightColor }
Repeater {
 model: Vocabulary.decks
 ChoiceButton { x: Theme.horizontalPageMargin; width: layout.width - 2*x; title: modelData.title; subtitle: modelData.subtitle + " · " + modelData.cards.length + " карточек"; onClicked: pageStack.push(Qt.resolvedUrl("SetupPage.qml"), {reverse: page.reverse, deck: Vocabulary.decks[index]}) }
}
Button { anchors.horizontalCenter: parent.horizontalCenter; text: "Назад"; onClicked: pageStack.pop() }

  }
  VerticalScrollDecorator {}
 }
}
