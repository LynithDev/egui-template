var cacheName = 'egui-app-pwa';
var filesToCache = [
    './',
    './index.html',
    './egui_app.js',
    './egui_app.wasm',
];

/* Start the service worker and cache all of the app's content */
self.addEventListener('install', function (e) {
    e.waitUntil(
        caches.open(cacheName).then((cache) => cache.addAll(filesToCache))
    );
});

/* Serve cached content when offline */
self.addEventListener('fetch', function (e) {
    e.respondWith(
        caches.match(e.request).then((res) => res || fetch(e.request))
    );
});
