#!/bin/sh

(
cat <<EOF
CREATE TABLE calendrier (
	id_date INTEGER PRIMARY KEY NOT NULL,
	annee INTEGER NOT NULL,
	mois INTEGER NOT NULL,
	jour INTEGER NOT NULL,
	mois_nom TEXT(8) NOT NULL,
	annee_mois INTEGER NOT NULL,
	jour_semaine INTEGER NOT NULL,
	trimestre TEXT(2) NOT NULL
);
CREATE TABLE clients (
	id_client TEXT (17) PRIMARY KEY NOT NULL,
	date_inscription TEXT (10)
);
CREATE TABLE employes (
	id_employe TEXT (32) PRIMARY KEY NOT NULL,
    date_debut INTEGER REFERENCES calendrier (id_date) NOT NULL,
	nom_utilisateur TEXT (128) NOT NULL,
	prenom TEXT (128) NOT NULL,
	nom TEXT (128) NOT NULL,
	hash_mdp TEXT (128) NOT NULL,
	mail TEXT (128) NOT NULL
);
CREATE TABLE logs (
	id_log INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    id_date INTEGER REFERENCES calendrier (id_date) NOT NULL,
	id_user TEXT(128) NOT NULL,
	action TEXT(128) NOT NULL,
	table_action TEXT(128) NOT NULL,
	id_ligne TEXT(128) NOT NULL,
	champs TEXT(128),
	detail TEXT(128)
);
CREATE TABLE produits (
	ean TEXT (13) PRIMARY KEY NOT NULL,
	categorie TEXT (128) NOT NULL,
	rayon TEXT (128) NOT NULL,
	libelle TEXT (128) NOT NULL,
	prix REAL NOT NULL
);
CREATE TABLE ventes (
	id_vente TEXT (35) PRIMARY KEY NOT NULL,
    id_date INTEGER REFERENCES calendrier (id_date) NOT NULL,
    id_client TEXT (17) REFERENCES clients (id_client) NOT NULL,
    id_employe TEXT (32) REFERENCES employes (id_employe) NOT NULL,
	ean TEXT (13) REFERENCES produits (ean) NOT NULL,
    id_ticket TEXT (6) NOT NULL
);
EOF
) | sqlite3 $1
if [ $? -eq 0 ] ; then
    echo "Created $1 database"
else
    echo "Error while creating $1 database"
fi