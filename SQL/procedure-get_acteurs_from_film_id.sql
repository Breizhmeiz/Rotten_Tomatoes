DROP PROCEDURE IF EXISTS get_acteurs_from_film_id;

DELIMITER //
CREATE PROCEDURE rotten_tomatoes.get_acteurs_from_film_id
(IN id INT(11))
BEGIN

SELECT GROUP_CONCAT(`identite_personne` SEPARATOR ', ')
 FROM personnes
 NATURAL JOIN acteur
 WHERE acteur.id_film = id
 ;

END //
DELIMITER ; 

# Test : 
# CALL get_acteurs_from_film_id(2)
