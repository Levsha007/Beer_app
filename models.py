from database import get_db

def init_db():
    """Инициализация базы данных для склада ГСМ (Вариант 3)"""
    db = get_db()
    
    # 1. Поставщики (не менее 6)
    db.execute_query("""
        CREATE TABLE IF NOT EXISTS suppliers (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL UNIQUE,
            address TEXT,
            phone VARCHAR(20),
            contact_person VARCHAR(100),
            inn VARCHAR(12),
            email VARCHAR(100),
            created_at TIMESTAMP DEFAULT NOW()
        )
    """, fetch=False)
    
    # 2. Продукция (не менее 4 наименований)
    db.execute_query("""
        CREATE TABLE IF NOT EXISTS products (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL UNIQUE,
            description TEXT,
            category VARCHAR(50),
            base_price DECIMAL(10,2),
            created_at TIMESTAMP DEFAULT NOW()
        )
    """, fetch=False)
    
    # 3. Характеристики для ГСМ (7 штук)
    db.execute_query("""
        CREATE TABLE IF NOT EXISTS characteristics (
            id SERIAL PRIMARY KEY,
            name VARCHAR(50) NOT NULL UNIQUE,
            unit VARCHAR(20),
            delta_x_default FLOAT DEFAULT 1.0,
            weight INTEGER DEFAULT 15,
            description TEXT
        )
    """, fetch=False)
    
    # 4. Связь: продукт-поставщик-характеристики
    db.execute_query("""
        CREATE TABLE IF NOT EXISTS product_characteristics (
            id SERIAL PRIMARY KEY,
            product_id INTEGER REFERENCES products(id) ON DELETE CASCADE,
            supplier_id INTEGER REFERENCES suppliers(id) ON DELETE CASCADE,
            characteristic_id INTEGER REFERENCES characteristics(id) ON DELETE CASCADE,
            min_norm FLOAT NOT NULL,
            max_norm FLOAT NOT NULL,
            real_value FLOAT NOT NULL,
            measurement_date TIMESTAMP DEFAULT NOW(),
            UNIQUE(product_id, supplier_id, characteristic_id)
        )
    """, fetch=False)
    
    print("✅ Таблицы созданы. Для заполнения данными выполните init.sql")