CREATE VIEW v_pilotes AS
SELECT films.titre, tomatometer_stats.label_tm_stat, audience_stats.label_audience_stat
 FROM films
  JOIN tomatometer_stats
   ON tomatometer_stats.id_tm_stat = films.id_tm_stat
  JOIN audience_stats
   ON audience_stats.id_audience_stat = films.id_audience_stat
;
   
# Test :
#SELECT * FROM v_pilotes
