const fs = require('fs');
const vm = require('vm');
const assert = require('assert');
const path = require('path');
const c = {};
vm.createContext(c);
vm.runInContext(fs.readFileSync(path.join(__dirname, '../qml/Vocabulary.js'), 'utf8').replace('.pragma library', ''), c);
assert.equal(c.decks.length, 6);
for (const deck of c.decks) {
 assert.equal(deck.cards.length, 10);
 const before = JSON.stringify(deck.cards);
 for (let n = 1; n <= 10; n++) for (let i = 0; i < 100; i++) {
  const cards = c.sample(deck.cards, n);
  assert.equal(cards.length, n);
  assert.equal(new Set(cards.map(x => x.word)).size, n);
 }
 assert.equal(JSON.stringify(deck.cards), before);
 for (const n of [0, -1, 11, 1.5, NaN]) assert.equal(c.sample(deck.cards, n).length, 0);
 for (const card of deck.cards) {
  assert(card.example && card.translation);
  assert.equal(c.question(card, true), card.translation);
  assert.equal(c.answer(card, true), card.word);
  assert.equal(c.question(card, false), card.word);
  assert.equal(c.answer(card, false), card.translation);
 }
}
const qml = fs.readFileSync(path.join(__dirname, '../qml/pages/StudyPage.qml'), 'utf8');
for (const name of ['restart', 'answer', 'recognitionRate']) {
 const method = qml.match(new RegExp('function ' + name + '\\([^]*?\\n[ ]{4}\\}'));
 assert(method); vm.runInContext(method[0], c);
}
c.Vocabulary = { sample: c.sample }; c.deck = c.decks[0]; c.count = 3; c.flick = {};
c.restart(); assert.equal(c.queue.length, 3);
c.currentCard = c.queue[0]; const first = c.currentCard; c.revealed = true; c.answer(false);
assert.equal(c.queue[3], first); assert.equal(c.repeats, 1);
while (!c.finished) { c.currentCard = c.queue[c.position]; c.revealed = true; c.answer(true); }
assert.equal(c.remembered, 3); assert.equal(c.recognitionRate(), 100); c.remembered = 1; assert.equal(c.recognitionRate(), 33); c.restart(); assert.equal(c.position, 0); assert.equal(c.repeats, 0); assert(!c.finished);
console.log('PASS: 6000 samples, bounds, directions, repeat queue, completion, restart and recognition rate');
