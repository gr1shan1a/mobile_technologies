import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Vocabulary.js" as Vocabulary
import "../components"
Page {
 id: page
 allowedOrientations: Orientation.All

 SilicaFlickable {
  anchors.fill: parent
  contentHeight: layout.height + Theme.paddingLarge
  Column {
   id: layout
   width: parent.width
   spacing: Theme.paddingLarge
 PageHeader { title: "VocExtender" }
Label { x: Theme.horizontalPageMargin; width: parent.width - 2*x; text: "01 / НАПРАВЛЕНИЕ"; wrapMode: Text.WordWrap; font.pixelSize: Theme.fontSizeSmall; color: Theme.secondaryColor }
Label { x: Theme.horizontalPageMargin; width: parent.width - 2*x; text: "Как будем повторять?"; font.pixelSize: Theme.fontSizeExtraLarge; wrapMode: Text.WordWrap }
Label { x: Theme.horizontalPageMargin; width: parent.width - 2*x; text: "Выберите язык вопроса. Перевод и пример откроются после вашего ответа."; wrapMode: Text.WordWrap; font.pixelSize: Theme.fontSizeSmall; color: Theme.secondaryColor }
ChoiceButton { x: Theme.horizontalPageMargin; width: parent.width - 2*x; title: "English → Русский"; subtitle: "Вспоминайте значение английских слов"; onClicked: pageStack.push(Qt.resolvedUrl("TopicsPage.qml"), {reverse: false}) }
ChoiceButton { x: Theme.horizontalPageMargin; width: parent.width - 2*x; title: "Русский → English"; subtitle: "Вспоминайте английские слова по переводу"; onClicked: pageStack.push(Qt.resolvedUrl("TopicsPage.qml"), {reverse: true}) }
Label { x: Theme.horizontalPageMargin; width: parent.width - 2*x; text: "6 тем · 60 карточек · без интернета"; wrapMode: Text.WordWrap; font.pixelSize: Theme.fontSizeSmall; color: Theme.secondaryColor }
Button { anchors.horizontalCenter: parent.horizontalCenter; text: "О приложении"; onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml")) }

  }
  VerticalScrollDecorator {}
 }
}
