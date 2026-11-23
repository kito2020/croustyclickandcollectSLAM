-- =====================================================================
--  Crousty Click & Collect : création de la base de données
--  Script n°1, à exécuter EN PREMIER (en tant que root).
--  phpMyAdmin : onglet « Importer » > choisir ce fichier > « Importer ».
--
--  Attention : ce script SUPPRIME la base « crousty » si elle existe déjà,
--  puis la recrée vide. Pratique pour repartir de zéro.
-- =====================================================================

SET NAMES utf8mb4;   -- les textes de ce fichier sont en UTF-8 (accents)

DROP DATABASE IF EXISTS crousty;
CREATE DATABASE crousty CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE crousty;

-- Les restaurants du réseau (au départ : les 3 restaurants pilotes).
CREATE TABLE restaurant (
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    nom                VARCHAR(100) NOT NULL,
    adresse            VARCHAR(200) NOT NULL,
    code_postal        CHAR(5)      NOT NULL,
    ville              VARCHAR(100) NOT NULL,
    telephone          VARCHAR(20)  NOT NULL,
    heure_ouverture    TIME         NOT NULL,
    heure_fermeture    TIME         NOT NULL,
    commandes_actives  BOOLEAN      NOT NULL DEFAULT TRUE,
    latitude           DECIMAL(10,7) NOT NULL,
    longitude          DECIMAL(10,7) NOT NULL
);

-- La carte : plats, suppléments et boissons.
CREATE TABLE produit (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    libelle      VARCHAR(100) NOT NULL,
    description  VARCHAR(255) NULL,
    categorie    ENUM('plat', 'supplement', 'boisson') NOT NULL,
    prix         DECIMAL(5,2) NOT NULL,          -- DECIMAL : le bon type pour de l'argent
    allergenes   VARCHAR(255) NULL,
    actif        BOOLEAN      NOT NULL DEFAULT TRUE,   -- FALSE = retiré de la carte
    CONSTRAINT chk_produit_prix CHECK (prix >= 0)
);

-- Les sauces que l'on peut choisir avec un plat (règle RG1).
CREATE TABLE sauce (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    libelle  VARCHAR(50) NOT NULL
);

-- Le personnel des restaurants (connexion à l'écran cuisine, sprint 5).
CREATE TABLE personnel (
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    identifiant        VARCHAR(50)  NOT NULL UNIQUE,
    mot_de_passe_hash  VARCHAR(255) NOT NULL,   -- l'empreinte du mot de passe, JAMAIS le mot de passe lui-même
    prenom             VARCHAR(50)  NOT NULL,
    nom                VARCHAR(50)  NOT NULL,
    role               ENUM('equipier', 'gerant') NOT NULL,
    restaurant_id      INT          NOT NULL,
    CONSTRAINT fk_personnel_restaurant FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

-- Les commandes passées sur le site (sprint 4).
CREATE TABLE commande (
    id                INT AUTO_INCREMENT PRIMARY KEY,   -- le « numéro de commande »
    restaurant_id     INT          NOT NULL,
    date_creation     DATETIME     NOT NULL,
    creneau_retrait   DATETIME     NOT NULL,            -- début du créneau de 15 minutes
    etat              VARCHAR(20)  NOT NULL DEFAULT 'Reçue',
    code_retrait      CHAR(4)      NOT NULL,            -- code à 4 chiffres donné au comptoir
    prenom_client     VARCHAR(50)  NOT NULL,
    telephone_client  VARCHAR(20)  NOT NULL,
    total             DECIMAL(6,2) NOT NULL,
    CONSTRAINT fk_commande_restaurant FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

-- Les articles de chaque commande.
CREATE TABLE ligne_commande (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    commande_id    INT          NOT NULL,
    produit_id     INT          NOT NULL,
    sauce_id       INT          NULL,                   -- NULL = sans sauce
    quantite       INT          NOT NULL,
    prix_unitaire  DECIMAL(5,2) NOT NULL,               -- prix au moment de la commande (règle RG5)
    CONSTRAINT fk_ligne_commande FOREIGN KEY (commande_id) REFERENCES commande(id),
    CONSTRAINT fk_ligne_produit  FOREIGN KEY (produit_id)  REFERENCES produit(id),
    CONSTRAINT fk_ligne_sauce    FOREIGN KEY (sauce_id)    REFERENCES sauce(id),
    CONSTRAINT chk_ligne_quantite CHECK (quantite > 0)
);
