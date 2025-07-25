'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon.png": "0cf751e681c81efff9455a77ef1157fd",
"flutter_bootstrap.js": "62f3e67a573e0cd4eb1cbf6ba768f7b1",
"main.dart.js": "43afcee16e2837e5c2a4d3b5c3fb4830",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"assets/FontManifest.json": "371c9355ed03cc85dce8a04f511ac049",
"assets/AssetManifest.bin.json": "281dd540cba0fb29ed79a9757381bdb6",
"assets/assets/dev.png": "9c1ae61fd83d89063c785d094c4d4ad5",
"assets/assets/appainter_theme_dark.json": "b39a9feaa3663f2df9971b42e1c083bc",
"assets/assets/dev_bg.png": "0db890f8a01ccf2bf9e136572776fa74",
"assets/assets/icon/icon.png": "6f35bff386bd769381ddb7c185c0a22f",
"assets/assets/icon/icon16.png": "0cf751e681c81efff9455a77ef1157fd",
"assets/assets/slide/gessport.jpeg": "0ca6a163a3d40ad88614907b33424334",
"assets/assets/slide/aliados.jpeg": "b2022e6be93dd6f49aca1e757cbd58aa",
"assets/assets/slide/neat.jpeg": "e2abf31ade97f60e96d3ba4d7946e1c2",
"assets/assets/slide/bodecom.jpeg": "ffd33ff380dcf8164e6534a471dc7432",
"assets/assets/slide/aliadosh.png": "f1db3bfa68cd23be53c0cc5c6a5004a5",
"assets/assets/slide/pedidos.jpeg": "2e3ae6622ab690b0f590ffb5773c78e0",
"assets/assets/slide/navi.jpeg": "a3f823ba463a5c00882b09c576826909",
"assets/assets/slide/navipuntos.jpeg": "02db8b3b93f464c466b78b68433034e6",
"assets/assets/slide/portafolio.jpeg": "7e673b9f8ba1411d97e1103a8a4b721a",
"assets/assets/slide/adomiPedidos.jpeg": "5e461172444145b63ec8d2cc4d366fd3",
"assets/assets/avatar_bg.png": "e560f18ed0dbfd01935e8fde36429420",
"assets/assets/dev_mint.png": "dbfd1eac416616215aa2b3cab055f083",
"assets/assets/appainter_theme.json": "48e1d72b1fa642cb024d06b75da9c997",
"assets/assets/ls_bg.png": "9f4854aabc21c64bfd3e5ac1e7e20e5a",
"assets/assets/avatar_mint.png": "d975114c40f2f825ba09e101804734f2",
"assets/assets/appainter_theme_blue.json": "bae51a1aeec2afd52824db7c9e486773",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/fonts/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/fonts/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/fonts/Poppins-SemiBold.ttf": "6f1520d107205975713ba09df778f93f",
"assets/NOTICES": "a0e927751553f79ae48e1b1ff16db1fa",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/AssetManifest.bin": "103bcbe0da920158d19c7c5a67b989e6",
"assets/AssetManifest.json": "d5a27288cdff73f3f9039ccbf185feef",
"manifest.json": "4f20272c79e0e12fb913826640b65ec5",
"icons/Icon-maskable-512.png": "55f00ec42a6c8aa6cfca4cb0a4ee03b5",
"icons/Icon-192.png": "8ec3527f2360da350dfaed481afb2690",
"icons/Icon-512.png": "55f00ec42a6c8aa6cfca4cb0a4ee03b5",
"icons/Icon-maskable-192.png": "8ec3527f2360da350dfaed481afb2690",
"index.html": "1b9c8ef2a3d4b333bf60f67d8addc013",
"/": "1b9c8ef2a3d4b333bf60f67d8addc013",
"version.json": "270fe30d26ae375cb02cbabf4609f5ab",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
