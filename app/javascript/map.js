ymaps = window.ymaps
ymaps.ready(init);

function init() {
  const myMap = new ymaps.Map('map', {
    center: [55.753994, 37.622093],
    zoom: 9
  });

  const address = document.getElementById("event-location").textContent;

  ymaps.geocode(address, {
    results: 1
  }).then(function (res) {
    const firstGeoObject = res.geoObjects.get(0),
      coords = firstGeoObject.geometry.getCoordinates(),
      bounds = firstGeoObject.properties.get('boundedBy');

    firstGeoObject.options.set('preset', 'islands#darkBlueDotIconWithCaption');
    firstGeoObject.properties.set('iconCaption', firstGeoObject.getAddressLine());

    myMap.geoObjects.add(firstGeoObject);
    myMap.setBounds(bounds, {
      checkZoomRange: true
    });
  });
}