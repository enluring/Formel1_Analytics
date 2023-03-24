--- constructorId,constructorRef,name,nationality,url
CREATE TABLE constructors (
    constructorId SERIAL PRIMARY KEY,
    constructorRef VARCHAR(30),
    name VARCHAR(100) UNIQUE,
    nationality VARCHAR(50),
    url VARCHAR(255)
);