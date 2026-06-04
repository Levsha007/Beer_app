-- =====================================================
-- ПОЛНАЯ ИНИЦИАЛИЗАЦИЯ БАЗЫ ДАННЫХ
-- Склад пива (Вариант 5)
-- 6+ производителей, 4+ товаров для каждого
-- =====================================================

-- Очистка старых таблиц
DROP TABLE IF EXISTS product_characteristics CASCADE;
DROP TABLE IF EXISTS characteristics CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;

-- ============ 1. ПОСТАВЩИКИ (6+) ============
CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    address TEXT,
    phone VARCHAR(20),
    contact_person VARCHAR(100),
    inn VARCHAR(12),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO suppliers (name, address, phone, contact_person, inn, email) VALUES
('ООО "Балтика"', 
 'г. Санкт-Петербург, пр. Обуховской Обороны, д. 112', 
 '+7 (812) 111-22-33', 
 'Андреев Дмитрий Сергеевич', 
 '7812345001', 
 'info@baltika.ru'),

('АО "Московская Пивоваренная Компания"', 
 'г. Москва, ул. Пивоваров, д. 15', 
 '+7 (495) 222-33-44', 
 'Волков Алексей Владимирович', 
 '7712345002', 
 'mpk@mpk.ru'),

('ООО "Heineken Россия"', 
 'г. Санкт-Петербург, ул. Нефтяная, д. 8', 
 '+7 (812) 333-44-55', 
 'Смирнов Константин Петрович', 
 '7812345003', 
 'heineken@heineken.ru'),

('АО "Пивоваренная компания "Волга"', 
 'г. Нижний Новгород, ул. Заводская, д. 45', 
 '+7 (831) 444-55-66', 
 'Морозов Иван Алексеевич', 
 '5212345004', 
 'volga@volga.ru'),

('ООО "САН ИнБев"', 
 'г. Клин, ул. Пивоваренная, д. 1', 
 '+7 (496) 555-66-77', 
 'Лебедев Сергей Николаевич', 
 '5012345005', 
 'saninbev@saninbev.ru'),

('АО "Тайга"', 
 'г. Новосибирск, ул. Сибирская, д. 23', 
 '+7 (383) 666-77-88', 
 'Кузнецов Павел Андреевич', 
 '5412345006', 
 'taiga@taiga.ru'),

('ООО "Крафт Пиво"', 
 'г. Екатеринбург, ул. Пивная, д. 10', 
 '+7 (343) 777-88-99', 
 'Новиков Денис Олегович', 
 '6612345007', 
 'kraft@kraft.ru'),

('АО "Арсенал Пиво"', 
 'г. Тула, ул. Оружейная, д. 5', 
 '+7 (487) 888-99-00', 
 'Фёдоров Михаил Иванович', 
 '7112345008', 
 'arsenal@arsenal.ru');

-- ============ 2. ПРОДУКЦИЯ ============
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    category VARCHAR(50),
    base_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO products (name, description, category, base_price) VALUES
-- Светлое пиво
('Жигулёвское', 'Классическое светлое, пастеризованное', 'Светлое', 120.00),
('Балтика №3', 'Светлое классическое, мягкий вкус', 'Светлое', 130.00),
('Сибирская корона', 'Светлое премиум, кристально чистое', 'Светлое', 150.00),
('Stella Artois', 'Бельгийское светлое, классический лагер', 'Светлое', 180.00),

-- Тёмное пиво
('Портер', 'Тёмное плотное, шоколадные ноты', 'Тёмное', 200.00),
('Старопрамен', 'Тёмное чешское, карамельный вкус', 'Тёмное', 170.00),
('Балтика №4', 'Тёмное оригинальное', 'Тёмное', 160.00),
('Гиннесс', 'Ирландский стаут, кофейные ноты', 'Тёмное', 250.00),

-- Нефильтрованное
('Нефильтрованное Жигули', 'Живое, неосветлённое', 'Нефильтрованное', 140.00),
('Берёзовское нефильтрованное', 'С натуральным осадком', 'Нефильтрованное', 135.00),

-- Крафтовое
('Инджой IPA', 'Американский индийский пейл-эль', 'Крафтовое', 220.00),
('Триппель', 'Бельгийское крепкое, фруктовое', 'Крафтовое', 280.00),
('Ламбик вишнёвый', 'Бельгийское спонтанное брожение', 'Крафтовое', 350.00),

-- Безалкогольное
('Балтика №0', 'Безалкогольное светлое', 'Безалкогольное', 100.00),
('Жигулёвское 0', 'Безалкогольное, освежающее', 'Безалкогольное', 95.00),

-- Бочковое
('Бочковое Ваканта', 'Живое, непастеризованное', 'Бочковое', 190.00),
('Чешское бочковое', 'Пилзенского типа', 'Бочковое', 185.00),

-- Премиум
('Русское Имперское', 'Крепкое, 8%', 'Премиум', 350.00),
('Балтика №9', 'Крепкое, 8%', 'Премиум', 120.00);

-- ============ 3. ХАРАКТЕРИСТИКИ КАЧЕСТВА ДЛЯ ПИВА (8 характеристик) ============
CREATE TABLE characteristics (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    unit VARCHAR(20),
    delta_x_default FLOAT DEFAULT 0.5,
    weight INTEGER DEFAULT 12,
    description TEXT
);

INSERT INTO characteristics (name, unit, delta_x_default, weight, description) VALUES
('Крепость', '% об.', 0.3, 20, 'Объёмная доля спирта, влияет на крепость напитка'),
('Пеностойкость', 'сек', 10.0, 15, 'Время устойчивости пены на поверхности (норма 180-240 сек)'),
('Цвет', 'EBC', 2.0, 10, 'Цветность по шкале Европейской пивной конвенции'),
('Прозрачность', '%', 5.0, 10, 'Степень прозрачности (100% - абсолютно прозрачное)'),
('Вкус', 'баллы', 0.5, 25, 'Органолептическая оценка вкуса по 10-балльной шкале'),
('Горечь', 'IBU', 2.0, 10, 'Интенсивность хмелевой горечи (единицы IBU)'),
('Наличие осадка', 'баллы', 0.5, 5, 'Оценка отсутствия осадка (5 - осадка нет)'),
('Срок годности', 'дни', 15.0, 5, 'Количество дней до истечения срока годности');

-- ============ 4. СВЯЗИ ПРОДУКТ-ПОСТАВЩИК-ХАРАКТЕРИСТИКИ ============
CREATE TABLE product_characteristics (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id) ON DELETE CASCADE,
    supplier_id INTEGER REFERENCES suppliers(id) ON DELETE CASCADE,
    characteristic_id INTEGER REFERENCES characteristics(id) ON DELETE CASCADE,
    min_norm FLOAT NOT NULL,
    max_norm FLOAT NOT NULL,
    real_value FLOAT NOT NULL,
    measurement_date TIMESTAMP DEFAULT NOW(),
    UNIQUE(product_id, supplier_id, characteristic_id)
);

-- ============ 5. ЗАПОЛНЕНИЕ ХАРАКТЕРИСТИК ============

DO $$
DECLARE
    sup RECORD;
    prod RECORD;
    char RECORD;
    random_val FLOAT;
    is_defect BOOLEAN;
BEGIN
    FOR sup IN SELECT id, name FROM suppliers LOOP
        FOR prod IN SELECT id, name FROM products ORDER BY random() LOOP
            FOR char IN SELECT id, name FROM characteristics LOOP
                is_defect := (random() < 0.3);
                
                CASE char.name
                    WHEN 'Крепость' THEN
                        IF is_defect THEN
                            random_val := 2 + random() * 10; -- ниже или выше нормы
                        ELSE
                            random_val := 4 + random() * 4; -- 4-8%
                        END IF;
                    
                    WHEN 'Пеностойкость' THEN
                        IF is_defect THEN
                            random_val := 60 + random() * 100; -- низкая пена
                        ELSE
                            random_val := 190 + random() * 40; -- 190-230 сек
                        END IF;
                    
                    WHEN 'Цвет' THEN
                        IF is_defect THEN
                            random_val := 80 + random() * 50; -- слишком тёмное для светлого
                        ELSE
                            random_val := 15 + random() * 35; -- EBC 15-50
                        END IF;
                    
                    WHEN 'Прозрачность' THEN
                        IF is_defect THEN
                            random_val := 50 + random() * 40; -- мутное
                        ELSE
                            random_val := 90 + random() * 10; -- 90-100%
                        END IF;
                    
                    WHEN 'Вкус' THEN
                        IF is_defect THEN
                            random_val := 4 + random() * 4; -- 4-8 баллов
                        ELSE
                            random_val := 8 + random() * 2; -- 8-10 баллов
                        END IF;
                    
                    WHEN 'Горечь' THEN
                        IF is_defect THEN
                            random_val := 5 + random() * 15; -- слишком слабая
                        ELSE
                            random_val := 20 + random() * 25; -- 20-45 IBU
                        END IF;
                    
                    WHEN 'Наличие осадка' THEN
                        IF is_defect THEN
                            random_val := 1 + random() * 3; -- есть осадок
                        ELSE
                            random_val := 5; -- осадка нет
                        END IF;
                    
                    WHEN 'Срок годности' THEN
                        IF is_defect THEN
                            random_val := 30 + random() * 60; -- маленький срок
                        ELSE
                            random_val := 120 + random() * 80; -- 120-200 дней
                        END IF;
                    
                    ELSE
                        random_val := 5;
                END CASE;
                
                random_val := ROUND(random_val::numeric, 2)::float;
                
                BEGIN
                    INSERT INTO product_characteristics 
                        (product_id, supplier_id, characteristic_id, min_norm, max_norm, real_value)
                    VALUES (
                        prod.id, sup.id, char.id,
                        CASE char.name
                            WHEN 'Крепость' THEN 4
                            WHEN 'Пеностойкость' THEN 180
                            WHEN 'Цвет' THEN 10
                            WHEN 'Прозрачность' THEN 90
                            WHEN 'Вкус' THEN 8
                            WHEN 'Горечь' THEN 20
                            WHEN 'Наличие осадка' THEN 4
                            WHEN 'Срок годности' THEN 120
                            ELSE 0
                        END,
                        CASE char.name
                            WHEN 'Крепость' THEN 8
                            WHEN 'Пеностойкость' THEN 250
                            WHEN 'Цвет' THEN 60
                            WHEN 'Прозрачность' THEN 100
                            WHEN 'Вкус' THEN 10
                            WHEN 'Горечь' THEN 50
                            WHEN 'Наличие осадка' THEN 5
                            WHEN 'Срок годности' THEN 250
                            ELSE 10
                        END,
                        random_val
                    )
                    ON CONFLICT DO NOTHING;
                EXCEPTION WHEN OTHERS THEN
                END;
            END LOOP;
        END LOOP;
    END LOOP;
END $$;

-- ============ ПРОВЕРКА РЕЗУЛЬТАТОВ ============
SELECT 'Поставщики: ' || COUNT(*) as info FROM suppliers
UNION ALL
SELECT 'Продукты: ' || COUNT(*) FROM products
UNION ALL
SELECT 'Характеристики: ' || COUNT(*) FROM characteristics
UNION ALL
SELECT 'Связей: ' || COUNT(*) FROM product_characteristics;

-- Статистика по браку
SELECT 
    COUNT(*) as всего_характеристик,
    SUM(CASE WHEN real_value < min_norm OR real_value > max_norm THEN 1 ELSE 0 END) as отклонений,
    ROUND(100.0 * SUM(CASE WHEN real_value < min_norm OR real_value > max_norm THEN 1 ELSE 0 END) / COUNT(*), 2) as процент_брака
FROM product_characteristics;

-- Статистика по каждой характеристике
SELECT 
    c.name as характеристика,
    c.unit,
    COUNT(*) as всего_измерений,
    ROUND(AVG(pc.real_value)::numeric, 2) as среднее,
    MIN(pc.real_value) as минимум,
    MAX(pc.real_value) as максимум,
    SUM(CASE WHEN pc.real_value < pc.min_norm OR pc.real_value > pc.max_norm THEN 1 ELSE 0 END) as отклонений
FROM product_characteristics pc
JOIN characteristics c ON pc.characteristic_id = c.id
GROUP BY c.name, c.unit, c.id
ORDER BY c.id;