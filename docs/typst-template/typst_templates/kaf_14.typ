#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1cm),
  numbering: none
)

#set text(
  lang: "ru",
  font: "Times New Roman",
  size: 12pt
)


#align(center)[
  #upper[ГУАП]
  #v(0.5cm)
  #upper[КАФЕДРА № 14]
  #v(2cm)
]

#grid(
  columns: (2fr),
  align(left)[
    #upper[ОТЧЕТ]\
    #upper[ЗАЩИЩЕН С ОЦЕНКОЙ]\
    #upper[]\
    #upper[ПРЕПОДАВАТЕЛЬ]
  ],
  align(center)[
    #v(0.5cm)
    #grid(
      columns: (2fr, 1fr, 2fr),
      gutter: 0.3em,
      [должность],
      [01.01.2026],
      [И.И. Иванов],
      line(length: 100%),
      line(length: 100%),
      line(length: 100%),
      [должность, уч. степень, звание],
      [подпись, дата],
      [инициалы, фамилия]
    )
  ]
)

#align(center)[
  #v(2cm)
  #upper[ОТЧЕТ О ЛАБОРАТОРНОЙ РАБОТЕ]
  #v(0.8cm)
  #text[Название лабораторной работы]
  #v(0.8cm)
  #text[по курсу:]
  #text[Название курса]
  #v(4cm)
]

#grid(
  columns: (2fr),
  align(left)[
    #upper[РАБОТУ ВЫПОЛНИЛ]
  ],
  align(center)[
    #v(0.5cm)
    #grid(
      columns: (1fr, 1fr, 1fr, 1.5fr),
      gutter: 0.3em,
      align(left)[#upper[СТУДЕНТ гр. №]],
      [2026],
      [01.01.2026],
      [Н.Н. Сидоров],
      line(length: 0%),
      line(length: 100%),
      line(length: 100%),
      line(length: 100%),
      [],
      [],
      [подпись, дата],
      [инициалы, фамилия]
    )

    #v(4cm)

    Санкт-Петербург 2026
]
)

