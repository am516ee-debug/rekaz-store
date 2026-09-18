/**
 * REKAZ Parfums - Configuration & Supabase Connector
 * Store WhatsApp: +201106385089
 */
window.REKAZ_CONFIG = {
  WHATSAPP_PHONE: '201106385089',
  SUPABASE_URL: localStorage.getItem('rekaz_supabase_url') || '',
  SUPABASE_ANON_KEY: localStorage.getItem('rekaz_supabase_anon_key') || '',
  ADMIN_PIN: localStorage.getItem('rekaz_admin_pin') || 'rekaz2026',
  STORE_NAME: 'رِكاز للعطور (REKAZ Parfums)',
  STORE_CURRENCY: 'ج.م'
};

// Initialize Supabase Client
window.rekazSupabase = null;
(function initSupabase() {
  const url = window.REKAZ_CONFIG.SUPABASE_URL;
  const key = window.REKAZ_CONFIG.SUPABASE_ANON_KEY;
  if (url && key && window.supabase && typeof window.supabase.createClient === 'function') {
    try {
      window.rekazSupabase = window.supabase.createClient(url, key);
      console.log('REKAZ: Supabase Connected successfully.');
    } catch (e) {
      console.warn('REKAZ: Supabase connection error:', e);
    }
  }
})();
