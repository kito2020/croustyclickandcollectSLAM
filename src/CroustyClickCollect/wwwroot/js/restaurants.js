document.addEventListener("DOMContentLoaded", () => {
    const mapElement = document.getElementById("carte-restaurants");
    const dataElement = document.getElementById("liste-restaurants-carte");

    if (!mapElement || !dataElement || typeof L === "undefined") {
        return;
    }

    const restaurants = Array.from(dataElement.children)
        .map((element) => ({
            nom: element.dataset.nom,
            adresse: element.dataset.adresse,
            latitude: Number(element.dataset.latitude),
            longitude: Number(element.dataset.longitude)
        }))
        .filter((restaurant) => Number.isFinite(restaurant.latitude)
            && Number.isFinite(restaurant.longitude)
            && (restaurant.latitude !== 0 || restaurant.longitude !== 0)
            && Math.abs(restaurant.latitude) <= 90
            && Math.abs(restaurant.longitude) <= 180);

    if (restaurants.length === 0) {
        return;
    }

    const map = L.map(mapElement);
    L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
        maxZoom: 19,
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    const bounds = [];

    restaurants.forEach((restaurant) => {
        const position = [restaurant.latitude, restaurant.longitude];
        bounds.push(position);

        const contenu = document.createElement("div");
        const nom = document.createElement("strong");
        nom.textContent = restaurant.nom;
        const adresse = document.createElement("p");
        adresse.className = "mb-0";
        adresse.textContent = restaurant.adresse;
        contenu.append(nom, adresse);

        L.marker(position).addTo(map).bindPopup(contenu);
    });

    if (bounds.length === 1) {
        map.setView(bounds[0], 14);
    } else {
        map.fitBounds(bounds, { padding: [30, 30] });
    }
});
