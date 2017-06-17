-- Up

CREATE TABLE thing (
  id INTEGER PRIMARY KEY,
  "text" TEXT NOT NULL,
  date_created INTEGER NOT NULL
);

INSERT INTO thing VALUES (1, 'Hello', CURRENT_TIMESTAMP);

-- Down

DROP TABLE thing;
