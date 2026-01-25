// Service Worker principal para PWA
const CACHE_NAME = 'familysync-v1';
const urlsToCache = [
    './',
    './calendar.html',
    './manifest.json',
    './icons/Icon-192.png',
    './icons/Icon-512.png'
];

// Instalar Service Worker
self.addEventListener('install', (event) => {
    console.log('Service Worker instalado');
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                console.log('Cache abierto');
                return cache.addAll(urlsToCache);
            })
    );
    self.skipWaiting(); // Activar inmediatamente
});

// Activar Service Worker
self.addEventListener('activate', (event) => {
    console.log('Service Worker activado');
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('Eliminando cache antiguo:', cacheName);
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    self.clients.claim(); // Reclamar control inmediatamente
});

// Estrategia: Network First, fallback a cache
self.addEventListener('fetch', (event) => {
    event.respondWith(
        fetch(event.request)
            .then((response) => {
                // Clonar la respuesta
                const responseToCache = response.clone();
                
                // Solo cachear si es una petición GET (PUT solo acepta GET)
                if (event.request.method === 'GET') {
                    caches.open(CACHE_NAME)
                        .then((cache) => {
                            cache.put(event.request, responseToCache);
                        });
                }
                
                return response;
            })
            .catch(() => {
                return caches.match(event.request);
            })
    );
});

