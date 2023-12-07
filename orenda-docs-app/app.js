// app.js
const express = require('express');
const app = express();
const port = 3000;

app.set('view engine', 'ejs');
app.use(express.static('public'));

app.get('/', (req, res) => {
  res.render('index', { title: 'Головна' });
});

app.get('/developer', (req, res) => {
  res.render('developer', { title: 'Розробник' });
});

app.get('/developer/home', (req, res) => {
  res.render('developer-home', { title: 'Головна' });
});

app.get('/developer/requirements', (req, res) => {
  res.render('developer-requirements', { title: 'Вимоги' });
});

// Додайте підменю для сторінки Вимоги
app.get('/developer/requirements/tasks', (req, res) => {
  res.render('developer-requirements-tasks', { title: 'Завдання' });
});

app.get('/developer/requirements/database-structure', (req, res) => {
  res.render('developer-requirements-database-structure', { title: 'Структура бази даних' });
});

app.get('/developer/requirements/user-interface', (req, res) => {
  res.render('developer-requirements-user-interface', { title: 'Користувацький інтерфейс' });
});

app.get('/developer/requirements/entities', (req, res) => {
  res.render('developer-requirements-entities', { title: 'Сутності' });
});

app.get('/developer/requirements/select-queries', (req, res) => {
  res.render('developer-requirements-select-queries', { title: 'SELECT запити' });
});

// Додайте сторінку "Guide" та підменю до неї
app.get('/guide', (req, res) => {
  res.render('guide', { title: 'Guide' });
});

// Додайте підменю для сторінки "Guide"
app.get('/guide/user', (req, res) => {
  res.render('user', { title: 'Користувачі' });
});

app.get('/guide/gifts', (req, res) => {
  res.render('gifts', { title: 'Подарунки' });
});

app.get('/guide/events', (req, res) => {
  res.render('events', { title: 'Події' });
});

app.get('/guide/complaints', (req, res) => {
  res.render('complaints', { title: 'Скарги' });
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
