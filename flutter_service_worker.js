'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "de6379434ad74faac1c7956586e3d134",
"icons/Icon-maskable-512.png": "2654700e944d96341671b5b559e0cd63",
"icons/Icon-192.png": "c0fe0a53503d6eb3fee297f313a5c0b6",
"icons/apple-touch-icon.png": "25f5f85a88e9713fa1f4c3711d85013a",
"icons/Icon-maskable-192.png": "f24b466c09a3a280dd1fb27bd1a74900",
"manifest.json": "e61b1937b003f236977fd47f8e7249a9",
"main.dart.mjs": "97f028ffa0c5d42488f7b506bc35bb47",
"index.html": "4fc33833e816f883473bc58d93d514ab",
"/": "4fc33833e816f883473bc58d93d514ab",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "e57f996f661d263da24abb004db31c57",
"assets/assets/svapna.svg": "9e91f7d6493a594291793d35be103e58",
"assets/assets/dreams_en.json": "631889f8d32c0e86d1406d783c8b400b",
"assets/assets/fonts/KantumruyPro-Regular.ttf": "307a9d5d3eef890236589b986ffd9cf1",
"assets/assets/fonts/KantumruyPro-BoldItalic.ttf": "7b6c6694858e22bae237b9ddc44fe81d",
"assets/assets/fonts/KantumruyPro-SemiBoldItalic.ttf": "a5c3421892d9e22d0d00eaef54dd0ba4",
"assets/assets/fonts/Inter-Italic-VariableFont_opsz,wght.ttf": "6dce17792107f0321537c2f1e9f12866",
"assets/assets/fonts/KantumruyPro-LightItalic.ttf": "7d7c2be107779d3e7f70cd924398466e",
"assets/assets/fonts/KantumruyPro-MediumItalic.ttf": "1badc249285304f18e3febf639dbbc87",
"assets/assets/fonts/KantumruyPro-Light.ttf": "32b89deca03ca45cb3dc293452c83033",
"assets/assets/fonts/KantumruyPro-ExtraLightItalic.ttf": "281dbfeb889f9f55f8689f9a094e79da",
"assets/assets/fonts/KantumruyPro-Bold.ttf": "a00945eaa49d658793e32a0fc5e99fd9",
"assets/assets/fonts/KantumruyPro-Italic.ttf": "e7079a96af5af5572d8320d6b9e60b1b",
"assets/assets/fonts/KantumruyPro-ExtraLight.ttf": "45516d01e18e9f416d9e620fe7d8c9e8",
"assets/assets/fonts/KantumruyPro-SemiBold.ttf": "1c5de94a9951d07fa2585ce34b1db159",
"assets/assets/fonts/Inter-VariableFont_opsz,wght.ttf": "0a77e23a8fdbe6caefd53cb04c26fabc",
"assets/assets/fonts/KantumruyPro-ThinItalic.ttf": "34c8c32cf54bfbbc3bed34daf55c4a58",
"assets/assets/fonts/KantumruyPro-Thin.ttf": "c70b60b036aeacc715b521d25ea0f076",
"assets/assets/fonts/KantumruyPro-Medium.ttf": "717768b0de691bb654b8fd869ea70658",
"assets/assets/dreams_km.json": "1a770ada120b0504c6273c6930fbc1b0",
"assets/fonts/MaterialIcons-Regular.otf": "cf5a86fb1451e42c586cebb485dff170",
"assets/NOTICES": "3511b9fc3e27219e2bc6534d667c1220",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "0b3bf82f931b6623d802711d96592a02",
"assets/AssetManifest.bin": "fd05366c58bfcaf3b3a658989464ef47",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"main.dart.wasm": "f3a2ebedeb2d6d2ac38675ff7bccff58",
"favicon.ico": "71add031da8de444d78d14d10e49759d",
"flutter_bootstrap.js": "6ce1340099a497b3ee463a298ca42387",
"version.json": "9a55b3ceb2f2bb15ba2cc60ff71695d2",
"main.dart.js": "c6a82f42678e6aa84fa638896b725871"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
