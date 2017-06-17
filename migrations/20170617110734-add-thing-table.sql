-- Up

CREATE TABLE thing (
  id INTEGER PRIMARY KEY,
  "text" TEXT NOT NULL,
  date_created INTEGER NOT NULL
);

-- Down

DROP TABLE thing;
