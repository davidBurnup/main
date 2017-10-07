(function() {
  var CACHE_NAME, CACHE_VERSION, onActivate, onInstall;

  CACHE_VERSION = 'v1';

  CACHE_NAME = 'sw-cache-' + CACHE_VERSION;

  onInstall = function(event) {
    console.log('[Serviceworker]', 'Installing!', event);
    event.waitUntil(caches.open(CACHE_NAME).then(function(cache) {
      return cache.addAll(['', '/assets/application-9ba9b24e0e23b177214a6af17f56f5e51627cc7e838598cb28f0e72c5ce5ae0d.css', '/offline.html']);
    }));
  };

  onActivate = function(event) {
    console.log('[Serviceworker]', 'Activating!', event);
    event.waitUntil(caches.keys().then(function(cacheNames) {
      return Promise.all(cacheNames.filter(function(cacheName) {
        return cacheName.indexOf(CACHE_VERSION) !== 0;
      }).map(function(cacheName) {
        return caches["delete"](cacheName);
      }));
    }));
  };

  self.addEventListener('install', onInstall);

  self.addEventListener('activate', onActivate);

  self.addEventListener('push', function(event) {
    var body, d, e, icon, tag, title;
    console.log("received push event & data", event, event.data);
    if (event.data && event.data.text()) {
      d = null;
      try {
        d = JSON.parse(event.data.text());
        console.log("received data", d);
      } catch (error) {
        e = error;
        console.warn(e);
        console.warn("Could not parse this data as JSON", event.data);
      }
      if (d != null) {
        title = d.title;
        body = d.body;
        icon = d.icon;
        tag = d.tag;
        event.waitUntil(self.registration.showNotification(title, {
          body: body,
          icon: icon,
          tag: tag,
          data: d
        }));
      }
    }
  });

  self.addEventListener('notificationclick', function(event) {
    var url;
    console.log('On notification click: ', event);
    if (Notification.prototype.hasOwnProperty('data')) {
      console.log('Using Data', event);
      url = event.notification.data.url;
      event.waitUntil(clients.openWindow(url));
    }
  });

}).call(this);
