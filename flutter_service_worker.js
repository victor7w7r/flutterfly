'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "ed4f017b2517d030b30432e7b9d3f7e4",
"/": "ed4f017b2517d030b30432e7b9d3f7e4",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "dccad73fa4d81429a1d1c209a5c9179e",
"main.dart.js": "34a79f03e75bd7ccbe75c533f4f2f060",
"version.json": "fb73be9c7715dfda47b42f1fc9cbe51d",
"splash/style.css": "d98100176788b88ac00f02386d064566",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/img/light-4x.png": "561ccc1de6e1d55d9eac58cf2fc45034",
"splash/img/light-2x.png": "3a1f96330ab3dfc913c0bf76b0588b79",
"splash/img/dark-2x.png": "3a1f96330ab3dfc913c0bf76b0588b79",
"splash/img/light-1x.png": "ef324409922dab8173b1a1c5b8c35a12",
"splash/img/dark-4x.png": "561ccc1de6e1d55d9eac58cf2fc45034",
"splash/img/dark-1x.png": "ef324409922dab8173b1a1c5b8c35a12",
"splash/img/light-3x.png": "d55a134f0b7dada317478e5191de7007",
"splash/img/dark-3x.png": "d55a134f0b7dada317478e5191de7007",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"manifest.json": "7cf2ddbdbd60c7e5848402a3c3756506",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/fonts/MaterialIcons-Regular.otf": "9b3fdc5b088f39dc316af22ae36f30dc",
"assets/AssetManifest.bin": "0550e4856cddaf09d2e8f1c3235a6f95",
"assets/AssetManifest.json": "e21e55b97af8b530522f9fb95d8896ce",
"assets/NOTICES": "2b60c0807902331696adfa42a13928e9",
"assets/FontManifest.json": "07ffd1708f1a916021f92ab4992183fb",
"assets/packages/fluent_ui/fonts/FluentIcons.ttf": "69087f3d260150793c1b9649e711f639",
"assets/packages/fluent_ui/assets/AcrylicNoise.png": "81f27726c45346351eca125bd062e9a7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "732c50d7dfa12a55a7a4a855a9a12be7",
"assets/assets/flutter-logo.png": "aa3f2685435e076f8d1ed5742144f232",
"assets/assets/logo.png": "5496e409411faaf5514f9cb8fe149108",
"assets/assets/fluent.jpg": "8d7d92b4bc9bc635cbbf6fbe1dada483",
"assets/assets/fonts/amina-reska.ttf": "ec775b6abf88ac9ba612bc4c31544a25",
"assets/assets/fonts/FuturaPTMedium.otf": "bd99f124d37cfd9caecec4fe24094334",
"assets/assets/statical.png": "0dd8302d2a2f0d3f2a6aad2880bc8a58",
"assets/assets/aqua-light.png": "d66003b3d310ad8e409ecbd6d6e479d2",
"assets/assets/brand.png": "da40d5ce83c7319258024f717c5cedaa",
"assets/assets/binance.png": "b4e7dad68dee0fd1eab14c4545cdffc1",
"assets/assets/material.jpg": "9c0da7a70bfa2a479b3fa3b134cdb9ff",
"assets/assets/aqua-black.png": "9a7e5d0a684c9901a59172c4425bcbe0",
"assets/assets/cupertino.jpg": "ccf433a787343cb7d3110671d7b438e9",
"assets/assets/brandwhite.png": "51e3e036c448960ac1468e610819b18d",
"icons/Icon-maskable-192.png": "90d6506bd23351b65c6a87b80dc9c80d",
"icons/Icon-192.png": "90d6506bd23351b65c6a87b80dc9c80d",
"icons/Icon-512.png": "f5d5634ab3a6509cfeba03f8a09d6f73",
"icons/Icon-maskable-512.png": "f5d5634ab3a6509cfeba03f8a09d6f73"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
