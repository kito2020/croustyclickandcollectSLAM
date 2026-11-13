-- =====================================================================
--  Crousty Click & Collect : données de départ
--  Script n°2, à exécuter en DEUXIÈME (après 01-schema.sql).
--
--  Toutes ces données sont FICTIVES (adresses, téléphones, personnes,
--  allergènes) : elles servent seulement à tester le site.
-- =====================================================================

-- Les textes de ce fichier sont en UTF-8 : on le dit à MySQL, sinon les
-- accents risquent d'être mal enregistrés (« RÃ©publique » au lieu de « République »).
SET NAMES utf8mb4;

USE crousty;

-- ---------------------------------------------------------------------
--  Les 3 restaurants pilotes (ouverts 7 jours sur 7, de 11h30 à 23h00)
-- ---------------------------------------------------------------------
INSERT INTO restaurant (nom, adresse, code_postal, ville, telephone, heure_ouverture, heure_fermeture, latitude, longitude) VALUES
('Tasty Crousty République', '12 rue de l''Exemple',      '75011', 'Paris',      '01 99 00 01 11', '11:30:00', '23:00:00', 48.8630, 2.3700),
('Tasty Crousty Gare',       '8 avenue du Prototype',     '69007', 'Lyon',       '04 99 00 02 22', '11:30:00', '23:00:00', 45.7500, 4.8300),
('Tasty Crousty Esplanade',  '3 place de la Maquette',    '67000', 'Strasbourg', '03 99 00 03 33', '11:30:00', '23:00:00', 48.5800, 7.7500);

-- ---------------------------------------------------------------------
--  La carte
-- ---------------------------------------------------------------------
INSERT INTO produit (libelle, description, categorie, prix, allergenes) VALUES
('Crousty classique',         'Riz, poulet frit croustillant et sauce au choix', 'plat',       9.00, 'Gluten, œuf, soja'),
('Crousty curry',             'Riz, poulet frit croustillant et sauce curry',    'plat',       9.50, 'Gluten, œuf, soja, moutarde'),
('Crousty classique XL',      'La barquette classique en grande portion',        'plat',      12.00, 'Gluten, œuf, soja'),
('Portion de poulet en plus', NULL,                                              'supplement', 3.00, 'Gluten, œuf'),
('Oignons frits',             NULL,                                              'supplement', 1.00, 'Gluten'),
('Sauce en plus',             NULL,                                              'supplement', 0.50, 'Œuf'),
('Eau 50 cl',                 NULL,                                              'boisson',    1.50, NULL),
('Soda 33 cl',                NULL,                                              'boisson',    2.50, NULL),
('Thé glacé 33 cl',           NULL,                                              'boisson',    2.50, NULL);

-- ---------------------------------------------------------------------
--  Les sauces (le choix « sans sauce » n'est pas une ligne : c'est sauce_id = NULL)
-- ---------------------------------------------------------------------
INSERT INTO sauce (libelle) VALUES
('Sauce maison'),
('Sauce sucrée-pimentée'),
('Sauce curry');

-- ---------------------------------------------------------------------
--  Comptes de test du personnel (sprint 5)
--  Mot de passe de TOUS ces comptes, en développement : Crousty2026!
--
--  BONNE PRATIQUE (bloc 3, SEC2) : la colonne contient l'EMPREINTE (hachage)
--  du mot de passe, calculée par ASP.NET Core. Le mot de passe lui-même
--  n'est stocké nulle part. Chaque empreinte est différente, même pour le
--  même mot de passe, car un « sel » aléatoire est ajouté avant le calcul.
-- ---------------------------------------------------------------------
INSERT INTO personnel (identifiant, mot_de_passe_hash, prenom, nom, role, restaurant_id) VALUES
('gerant.republique',   'AQAAAAIAAYagAAAAECTWJtEM2d6znrCQJdyD80ObowvuulNt3iWCm+B+iVwi2mY1IiT1J5GmBBUtm3NbQg==', 'Samia',  'Benali',  'gerant',   1),
('equipier.republique', 'AQAAAAIAAYagAAAAEPiGeyuIQMR8bgciQynbi89sJpKjUyNJ6FYGVggNVLSGXHUnmluu4mx9xdFkO1aSrg==', 'Tom',    'Martin',  'equipier', 1),
('gerant.gare',         'AQAAAAIAAYagAAAAEKzcZGVeEjDMLZfWXTYhGXgfMHAG5XwC7V0gOKVx2FI2KDyKrwcaG1izdB+cVSw7dA==', 'Inès',   'Moreau',  'gerant',   2),
('equipier.gare',       'AQAAAAIAAYagAAAAEHe30I961wvOYaO/1ev6llYnb+a4zylgmRwWrz/CCMPTu5uFQuNOTUKm5jJswhIhFA==', 'Lucas',  'Petit',   'equipier', 2),
('gerant.esplanade',    'AQAAAAIAAYagAAAAEG3XcKhBKO/UBZtBU1Km0SN0buFI15oxV6EuGCfTO9qDo1s5VzQ3caWITsOrmq9ZnQ==', 'Nadia',  'Klein',   'gerant',   3),
('equipier.esplanade',  'AQAAAAIAAYagAAAAELEtAfoQUG0Izmyp30bGly5W3uhp2P8VXbqmj1HLSmHbnF5hlv/EThQgYei2ordWWQ==', 'Hugo',   'Weber',   'equipier', 3);
