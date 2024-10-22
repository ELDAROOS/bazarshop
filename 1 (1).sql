CREATE TABLE UserDatabase (
    userId Serial PRIMARY KEY,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    pass VARCHAR(255),
    email VARCHAR(255),
    userRole VARCHAR(20),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM UserDatabase;

DROP TABLE UserDatabase;

CREATE TABLE Category (
    categoryId INT PRIMARY KEY,
    categoryName VARCHAR(255)
);

CREATE TABLE Product (
    productId INT PRIMARY KEY,
    productName VARCHAR(255),
    productPrice DECIMAL(10, 2),
    description TEXT,
    image VARCHAR(255),
    productSize VARCHAR(3),
    productColor VARCHAR(255),
    categoryId INT,
    FOREIGN KEY (categoryId) REFERENCES Category(categoryId) ON DELETE SET NULL
);

CREATE TABLE Orders (
    orderId INT PRIMARY KEY,
    userId INT,
    orderDate TIMESTAMP,
    total DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (userId) REFERENCES UserDatabase(userId) ON DELETE CASCADE
);

CREATE TABLE OrderItems (
    orderItemId INT PRIMARY KEY,
    orderId INT,
    productId INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId) ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES Product(productId) ON DELETE CASCADE
);

CREATE TABLE Address (
    addressId INT PRIMARY KEY,
    userId INT,
    address VARCHAR(255),
    country VARCHAR(255),
    city VARCHAR(255), 
    postalCode VARCHAR(20),
    FOREIGN KEY (userId) REFERENCES UserDatabase(userId) ON DELETE CASCADE
);

CREATE TABLE Cart (
    cartId INT PRIMARY KEY,
    userId INT,
    FOREIGN KEY (userId) REFERENCES UserDatabase(userId) ON DELETE CASCADE
);

CREATE TABLE CartElements (
    cartItemId INT PRIMARY KEY,
    cartId INT,
    productId INT,
    quantity INT,
    FOREIGN KEY (cartId) REFERENCES Cart(cartId) ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES Product(productId) ON DELETE CASCADE
);
