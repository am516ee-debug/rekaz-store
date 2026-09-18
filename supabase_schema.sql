-- ========================================================
-- REKAZ Parfums - Supabase Database Schema (PostgreSQL)
-- انسخ هذا الكود بالكامل والصقه في Supabase -> SQL Editor -> Run
-- ========================================================

-- 1. إنشاء جدول الطلبات الرئيسي
CREATE TABLE IF NOT EXISTS public.orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_number TEXT UNIQUE NOT NULL,
    customer_name TEXT NOT NULL,
    customer_phone TEXT NOT NULL,
    governorate TEXT NOT NULL,
    address TEXT NOT NULL,
    notes TEXT DEFAULT '',
    promo_code TEXT DEFAULT '',
    discount_amount NUMERIC DEFAULT 0,
    subtotal NUMERIC NOT NULL,
    shipping_cost NUMERIC DEFAULT 0,
    total_price NUMERIC NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending', -- pending, confirmed, shipped, delivered, cancelled
    items JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. إنشاء فهارس سريعة للبحث
CREATE INDEX IF NOT EXISTS idx_orders_order_number ON public.orders(order_number);
CREATE INDEX IF NOT EXISTS idx_orders_customer_phone ON public.orders(customer_phone);
CREATE INDEX IF NOT EXISTS idx_orders_status ON public.orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON public.orders(created_at DESC);

-- 3. تفعيل أمان الصفوف (Row Level Security)
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

-- 4. سياسة السماح للعملاء بإرسال الطلبات (Insert) دون الحاجة لتسجيل حساب
DROP POLICY IF EXISTS "Allow public insert" ON public.orders;
CREATE POLICY "Allow public insert" ON public.orders
    FOR INSERT WITH CHECK (true);

-- 5. سياسة السماح بقراءة الطلبات وعرضها في لوحة التحكم
DROP POLICY IF EXISTS "Allow anon read" ON public.orders;
CREATE POLICY "Allow anon read" ON public.orders
    FOR SELECT USING (true);

-- 6. سياسة السماح للأدمن بتحديث حالات الطلبات (Update)
DROP POLICY IF EXISTS "Allow anon update" ON public.orders;
CREATE POLICY "Allow anon update" ON public.orders
    FOR UPDATE USING (true) WITH CHECK (true);

-- 7. سياسة السماح بحذف الطلبات من لوحة التحكم (Delete)
DROP POLICY IF EXISTS "Allow anon delete" ON public.orders;
CREATE POLICY "Allow anon delete" ON public.orders
    FOR DELETE USING (true);

-- ========================================================
-- تم إنشاء الجداول وسياسات الأمان بنجاح لمشروع رِكاز
-- ========================================================
