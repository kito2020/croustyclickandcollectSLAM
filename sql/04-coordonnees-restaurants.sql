-- Mise a jour pour une base crousty deja creee avant l'ajout de la carte.
-- Les colonnes sont ajoutees uniquement si elles n'existent pas encore.
USE crousty;

ALTER TABLE restaurant
    ADD COLUMN IF NOT EXISTS latitude DECIMAL(10,7) NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS longitude DECIMAL(10,7) NOT NULL DEFAULT 0;

-- Coordonnees indicatives dans les villes : les adresses du projet sont fictives.
UPDATE restaurant SET latitude = 48.8630, longitude = 2.3700 WHERE ville = 'Paris';
UPDATE restaurant SET latitude = 45.7500, longitude = 4.8300 WHERE ville = 'Lyon';
UPDATE restaurant SET latitude = 48.5800, longitude = 7.7500 WHERE ville = 'Strasbourg';
