--basic requirement for access
--be sure to tick option to also view tables without geometry

GRANT USAGE ON SCHEMA addbase TO public;
GRANT SELECT ON ALL TABLES IN SCHEMA addbase TO public;



--more general/comprehensive options

GRANT USAGE ON SCHEMA myschema TO "name";
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA myschema TO "name";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA myschema TO "name";
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA myschema TO "name";

GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO "restricted_group_name_or_login";
GRANT EXECUTE ON ALL SEQUENCES IN SCHEMA myschema TO "restricted_group_name_or_login";
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA myschema TO "restricted_group_name_or_login";

GRANT SELECT ON TABLE myschema.lizmap_search TO "restricted_group_name_or_login";
