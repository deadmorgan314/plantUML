CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50),
    shipping_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (shipping_id) REFERENCES Shipping(shipping_id)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    shipping_method VARCHAR(100) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL
);

/*
Связи между таблицами
Customers - Orders: Связь один-ко-многим. Один клиент может сделать несколько заказов.
Orders - OrderDetails: Связь один-ко-многим. Один заказ может содержать несколько товаров.
Products - OrderDetails: Связь один-ко-многим. Один товар может быть в нескольких строках заказов.
Orders - Payments: Связь один-ко-одному. Каждый заказ должен иметь один платеж.
Products - Categories: Связь многие-к-одному. Каждый товар может принадлежать одной категории.
Orders - Shipping: Связь один-ко-многим. Один заказ может иметь одну доставку, но доставка может применяться к разным заказам.
Дополнительные таблицы 
Users: таблица для хранения информации о пользователях (если в магазине используются учетные записи).
Discounts: таблица для хранения скидок и акций, которые могут применяться к заказам или товарам.
Пример использования
Добавление заказа: Когда клиент размещает заказ, данные добавляются в таблицы Orders и OrderDetails.
Управление запасами: При каждом заказе из таблицы Products обновляется количество доступного товара.
Платежи: После успешного завершения заказа запись добавляется в таблицу Payments.
Визуализация связей
Customers (1) ↔ (∞) Orders
Orders (1) ↔ (∞) OrderDetails
Products (1) ↔ (∞) OrderDetails
Orders (1) ↔ (∞) Payments
Products (∞) ↔ (1) Categories
*/
