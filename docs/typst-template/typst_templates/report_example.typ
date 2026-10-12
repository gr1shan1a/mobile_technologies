#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1cm),
  numbering: none,
  footer: context {
    let p = counter(page).get().first()
    if p > 1 {
      align(center)[#p]
    }
  }
)

#set text(
  lang: "ru",
  font: "Times New Roman",
  size: 12pt
)

//Рамка для блока с кодом
#show raw: block.with(
  fill: luma(245),
  inset: 10pt,
  radius: 5pt,
  stroke: luma(200),
)

//Для таблиц - подпись сверху
#show figure.where(kind: table): set figure.caption(position: top)



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


= Описание задачи
В описании задачи приводится номер задания из методического пособия, текст задания или формулировка.
Например: написать программу для вычисления формулы $ Y = A + B + C $

= Формализация
В формализации подробно описываются этапы решения задачи, используемые средства, ограничения на входные данные,
типы используемых переменных, обоснованные ограничения на запуск программы и т.д.

= Блок-схема
Если по условию задания от вас требуется привести блок-схему, то вы так же можете это сделать внутри Typst файла
следующим способом:
#import "@preview/fletcher:0.5.8": diagram, node, edge, shapes

#import shapes: parallelogram

#figure(
  diagram(
    spacing: (2.2em, 3.8em),
    node-stroke: 1pt + black,
    node-fill: none,

    node((0, 0), [Начало], shape: rect, corner-radius: 1em),

    edge("-|>"),

    //Вывод как действие
    node((0, -1), [Вывод "Hello, World!"], shape: rect),

    edge("-|>"),

    //Вывод как на консоль
    node((0, -2), [Вывод\n"Hello, World!"],
      shape: parallelogram,
      inset: 1em,
    ),

    edge("-|>"),

    node((0, -3), [Конец], shape: rect, corner-radius: 1em),
  ),

  caption: [Блок-схема простейшего алгоритма],
)

Но могу сразу сказать, что в самом Typst целиком всю схему сделать очень тяжело, потому вы можете рисовать её в
отдельном редакторе и вставлять как кратинку.

= Исходный код программы
В исходном коде приводится полный исходный код вашей программы.

Код на Rust:
```rust
fn main() {
    println!("Hello world!");
}
```

Код на Си:
```c
int main (int argc, char* argv[]) {
    printf("Hello, World!");
}
```

Код на ассемблере:
```asm
.section .data
msg:
  .ascii "Hello, world!\n"
len = . - msg

.section .text
.global _start

_start:
  mov $1, %rax
  mov $1, %rdi
  lea msg(%rip), %rsi
  mov $len, %rdx
  syscall

  mov $60, %rax
  xor %rdi, %rdi
  syscall
```

= Тестирование
В секции тестирования вы должны привести 3-4 сценария, которые собираетесь тестировать и ожидаемый результат.
Ниже, после этого, вы прикладываете скриншоты вашего вывода, которые полностью покрывают тестовые сценарии,
чтобы можно было проверить ваш ожидаемый результат из выводов.

#figure(
  table(
    columns: 5,
    align: center + horizon,
    // stroke: none,
    table.hline(),
    [*Набор тестовых данных *], [*A*], [*B*], [*C*], [*Сумма*],
    table.hline(),
    [1], [12],   [8],   [5],  [$12 + 8 + 5 = 25$],
    [2], [3.5],  [9],  [14],  [$3.5 + 9 + 14 = 26.5$],
    [3], [25],  [-4],   [7],  [$25 -4 + 7 = 28$],
    table.hline(),
  ),
  caption: [Расчёт выражения $A + B + C$ для трёх различных наборов],
)

#figure(
  image("output_test.png", width: 80%),
  caption: [Вывод тестовых результатов],
) <glacier>

= Выводы
В выводах вы должны резюмировать все то, что вы сделали в лабораторной работе: какая задача стояла, что вы сделали для её решения
(часть того, что в формализации писали, написали программу, проверили результаты программы с ручным тестированием, если, конечно, ручное тестирование можно учесть в вашем варианте задачи).
Потом вы пишите о том, что раз ваши данные сошлись (если тестирование ручное и программное выполненно), то #quote[лабораторная работа выполнена верно и все поставленные цели достигнуты].
