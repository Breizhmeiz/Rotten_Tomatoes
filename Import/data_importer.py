#!/usr/bin/env python3
# Importe la liste des acteurs dans la base.

import mysql.connector
import pandas as pd

from config import bdd_config

#: Exit status
status = 0
#: invalids data found
invalids = []


def import_df(path: str) -> pd.DataFrame:
    """Return a Pandas DataFrame from Path

    :path: string defining the URI of the csv file
    :returns: a DataFrame

    """

    df = pd.read_csv(path)

    return df


def execute_select(query, values=None):
    bdd = mysql.connector.connect(**bdd_config)
    cursor = bdd.cursor()

    cursor.execute(query, values)

    result = cursor.fetchall()
    # result = []
    # for tuple in cursor:
    #     result.append(tuple)
    bdd.close()
    return result


def execute_insert(query, values):
    bdd = mysql.connector.connect(**bdd_config)
    cursor = bdd.cursor()

    cursor.execute(query, values)
    result = cursor.lastrowid
    bdd.commit()

    bdd.close()
    return result


def execute_update(query, values):
    """SQL UPDATE

    :query: request to execute
    :values: values to insert
    :returns: Number of lines updated (rowcount)

    """
    bdd = mysql.connector.connect(**bdd_config)
    cursor = bdd.cursor()

    cursor.execute(query, values)
    result = cursor.rowcount
    bdd.commit()

    bdd.close()
    return result


def select_personne(identite: str) -> int:
    """Retourne id_personne de la personne

    :identite: personne à rechercher
    :returns: id_personne

    """
    req = "SELECT id_personne FROM personnes WHERE identite_personne = %(identite)s LIMIT 1"
    val = {"identite": identite}
    id = execute_select(req, val)
    id = id[0][0]  # execute_select renvoie un tableau de tuples
    if id < 1:
        print(id, identite)
        invalids.append(identite)
    else:
        return(id)


def insert_personne(identite: str) -> int:
    """Insert une personne en base et retourne son id_personne

    :identite: Identité de la personne à inserrer
    :returns: id_personne

    """
    req = "INSERT INTO personnes (identite_personne) VALUES (%(identite)s)"
    val = {"identite": identite}
    id = execute_insert(req, val)
    if id < 1:
        invalids.append(identite)
    else:
        return(id)


def add_personnes(personnes):
    """Ajoute les personnes en base

    :personnes: TODO
    :returns: Liste des id insérées

    """
    pers = []
    if personnes != personnes:
        # Si in n'y a pas d'acteurs, on passe au suivant.
        pass
    else:
        for p in personnes.split(', '):
            try:
                id = insert_personne(p)
            except mysql.connector.errors.IntegrityError:
                id = select_personne(p)
            finally:
                if 'id' in locals():
                    pers.append(id)
    return pers


def select_compagnie(identite: str) -> int:
    """Retourne id_compagnie de la compagnie

    :identite: compagnie à rechercher
    :returns: id_compagnie

    """
    req = "SELECT id_compagnie FROM compagnies WHERE identite_compagnie = %(identite)s LIMIT 1"
    val = {"identite": identite}
    id = execute_select(req, val)
    id = id[0][0]  # execute_select renvoie un tableau de tuples
    if id < 1:
        print(id, identite)
        invalids['compagnie'].append(identite)
    else:
        return(id)


def insert_compagnie(identite: str) -> int:
    """Insert une compagnie en base et retourne son id_compagnie

    :identite: Identité de la compagnie à inserrer
    :returns: id_compagnie

    """
    req = "INSERT INTO compagnies (identite_compagnie) VALUES (%(identite)s)"
    val = {"identite": identite}
    id = execute_insert(req, val)
    if id < 1:
        invalids['compagnie'].append(identite)
    else:
        return(id)


def add_compagnie(compagnie):
    """Ajoute les compagnie en base

    :compagnie: Compagnie à inserrer
    :returns: Liste des id insérées

    """
    if compagnie != compagnie:
        id = None
    else:
        try:
            id = insert_compagnie(compagnie)
        except mysql.connector.errors.IntegrityError:
            id = select_compagnie(compagnie)
        finally:
            if 'id' not in locals():
                id = None
    return id


def insert_film(film) -> int:
    """Insert un film en base et retourne son id

    :film: film à inserrer
    :returns: id

    """
    req = """INSERT INTO `films` (
            `url`,
            `titre`,
            `info`,
            `critique`,
            `durée`,
            `tomatometer_count`,
            `audience_rating`,
            `audience_count`
            ) VALUES (
            %(rotten_tomatoes_link)s,
            %(movie_title)s,
            %(movie_info)s,
            %(critics_consensus)s,
            %(runtime)s,
            %(tomatometer_count)s,
            %(audience_rating)s,
            %(audience_count)s,
            )"""
    req = """INSERT INTO `films` (
            `id_film`,
            `titre`,
            `url`,
            `info`,
            `critique`,
            `durée`,
            `tomatometer_count`,
            `audience_rating`,
            `audience_count`,
            `id_compagnie`
            ) VALUES (
            NULL,
            %(movie_title)s,
            %(rotten_tomatoes_link)s,
            %(movie_info)s,
            %(critics_consensus)s,
            %(runtime)s,
            %(tomatometer_count)s,
            %(audience_rating)s,
            %(audience_count)s,
            %(id_compagnie)s
            ); """
    val = (film)
    id = execute_insert(req, val)
    print("Valeur : ", id)
    if id < 1:
        invalids.append(film)
    else:
        return(id)


def link_personne(film_id: int, personne_id: int, table: str) -> int:
    """Insert un item en base et retourne son id

    :film_id: id du film
    :personne_id: id de la personne
    :table: table à inserer
    :returns: TODO

    """
    req = f"""INSERT INTO { table } (id_film, id_personne) VALUES (%(film_id)s, %(personne_id)s)"""
    val = {"table": table, "film_id": film_id, "personne_id": personne_id}
    id = execute_insert(req, val)
    return(id)


def add_items(items, table, id_label, labels):
    """Ajoute les items en base

    :items: TODO
    :table: Nom de la table
    :id_label: Nom de la clé primaire
    :labels: Noms des champs
    :returns: Liste des id insérées

    """
    ids = []
    if items != items:
        # Si in n'y a pas d'item, on passe au suivant.
        print("Empty items ", table, labels)
        pass
    else:
        for item in items.split(', '):
            try:
                id = insert_item(item, table, labels)
            except mysql.connector.errors.IntegrityError:
                id = select_item(item, table, id_label, labels)
            finally:
                if 'id' in locals():
                    ids.append(id)
    return ids


def select_item(item: str, table: str, id_label: str, label: str) -> int:
    """Retourne l'id de l'item

    :item: champ à rechercher
    :table: table dans laquelle chercher
    :id_label: nom de la clé
    :label: champ dans lequel chercher
    :returns: id

    """
    req = f"SELECT %(id_label)s FROM { table } WHERE %(label)s = %(item)s LIMIT 1"
    val = {"item": item, "table": table, "id_label": id_label, "label": label}
    id = execute_select(req, val)
    id = id[0][0]  # execute_select renvoie un tableau de tuples
    if id < 1:
        invalids[table].append(item)
    return(id)


def insert_item(item: str, table: str, label: str) -> int:
    """Insert un item en base et retourne son id

    :item: item à inserrer
    :table: table dans laquelle inserrer
    :label: champs à inserer
    :returns: id_personne

    """
    print("Insert ", item, table, label)
    req = f"""INSERT INTO { table } (%(label)s) VALUES (%(item)s)"""
    val = {"item": item, "table": table, "label": label}
    id = execute_insert(req, val)
    if id < 1:
        print(table, " : Invalid item : ", item)
        invalids[table].append(item)
    else:
        return(id)


def log_to_file(file, logs):
    """Log logs to file

    :file: file path to log to
    :logs: data to log
    :returns: TODO

    """
    with open(file, 'w+') as f:
        for echec in logs:
            f.writelines([echec, '\n'])


df = import_df("rotten_tomatoes_movies.csv")

print(df.shape)
print(df.columns)
# 'rotten_tomatoes_link', 'movie_title', 'movie_info',
# 'critics_consensus', 'content_rating', 'genres', 'directors', 'authors',
# 'actors', 'original_release_date', 'streaming_release_date', 'runtime',
# 'production_company', 'tomatometer_status', 'tomatometer_rating',
# 'tomatometer_count', 'audience_status', 'audience_rating',
# 'audience_count', 'tomatometer_top_critics_count',
# 'tomatometer_fresh_critics_count', 'tomatometer_rotten_critics_count'

for index, ligne in df.iterrows():
    print(ligne.movie_title)
    film = {
            'rotten_tomatoes_link': ligne.rotten_tomatoes_link,
            'movie_title': ligne.movie_title,
            'movie_info': ligne.movie_info,
            'critics_consensus': ligne.critics_consensus,
            'content_rating': ligne.content_rating,
            'original_release_date': ligne.original_release_date,
            'streaming_release_date': ligne.streaming_release_date,
            'runtime': float(ligne.runtime),
            'production_company': ligne.production_company,
            'tomatometer_status': ligne.tomatometer_status,
            'tomatometer_rating': float(ligne.tomatometer_rating),
            'tomatometer_count': float(ligne.tomatometer_count),
            'audience_status': ligne.audience_status,
            'audience_rating': float(ligne.audience_rating),
            'audience_count': float(ligne.audience_count),
            'tomatometer_top_critics_count': int(ligne.tomatometer_top_critics_count),
            'tomatometer_fresh_critics_count': int(ligne.tomatometer_fresh_critics_count),
            'tomatometer_rotten_critics_count': int(ligne.tomatometer_rotten_critics_count),
            }
    film.update({'id_compagnie': add_compagnie(ligne.production_company)})
    film.update({'id': insert_film(film)})
    print(film)
    #genres = add_items(ligne.genres, table='genres', id_label='id_genre', labels='label_genre')
    directors = add_personnes(ligne.directors)
    print(directors)
    for d in directors:
        link_personne(film['id'], d, "realisateur")
    authors = add_personnes(ligne.authors)
    for a in authors:
        link_personne(film['id'], a, "auteur")
    actors = add_personnes(ligne.actors)
    print(authors)
    print(actors)

#           id_tm_stat
#            %(content_rating)s,
#            %(original_release_date)s,
#            %(streaming_release_date)s,
#            %(audience_status)s,
#            %(tomatometer_top_critics_count)s,
#            %(tomatometer_fresh_critics_count)s,
#            %(tomatometer_rotten_critics_count)s

exit(0)

if len(invalids) > 0:
    log_to_file("adresses.errors", invalids)
    print("Errors : ", invalids, sep=' ')
    status = 1

exit(status)
