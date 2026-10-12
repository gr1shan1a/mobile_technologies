import QtQuick 2.0
import Sailfish.Silica 1.0
Page {
 SilicaFlickable {
  anchors.fill: parent
  contentHeight: layout.height + Theme.paddingLarge
  Column {
   id: layout
   width: parent.width
   spacing: Theme.paddingLarge
   PageHeader { title: "VocExtender" }
   Label { x: Theme.horizontalPageMargin; width: parent.width - 2*x; wrapMode: Text.WordWrap; font.pixelSize: Theme.fontSizeSmall; text: "Версия 0.3.0\n\n60 карточек, 6 тем и два направления перевода. Выберите режим и количество слов — приложение создаст случайную подборку.\n\nListening, Grammar, Speaking и Writing задают инструкции для самостоятельной работы с одной тематической базой. В Listening пока нет аудио. Приложение не записывает речь и не проверяет текст автоматически.\n\nСложные карточки возвращаются в конец очереди. Прогресс хранится только во время тренировки.\n\nНезависимый учебный проект, не официальный продукт IELTS." }
   Button { anchors.horizontalCenter: parent.horizontalCenter; text: "Назад"; onClicked: pageStack.pop() }
  }
  VerticalScrollDecorator {}
 }
}
