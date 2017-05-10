To import gin records from git imports follow the following steps

    - import the existing database (staging/production)
    - run rails:db:migrate
    - check that the pg sequence values are updated(eg select setval('commodities_id_seq',(select max(id) from commodities)); on the db to reset the commodities sequence)
    - run rails db:seed
    - run rails cats:commodities:update 
    - run rails cats:migrate:location
    - run rails cats:fdp:update_locations

Optional(not needed for the import but for the application to work)

    -run rails cats:hubs:create_default_warehouse
    -run rails cats:users:update_admin


After this run all statements in db/scripts/git_imports_final.sql on the database.
now the git_imports table is cleaned up and can be imported. To do this:

    - run rails cats:grn_import:update_projects
    - run rails cats:grn_import:import


----------------------------------------------------------------------------------------------------------------------------------

To import grn records from grn_imports follow the following steps
/* Assuming you have already run the above scripts for git_imports */


After this run all statements in db/scripts/grn_imports.sql on the database.
now the git_imports table is cleaned up and can be imported. To do this:

    - run rails cats:grn_import:update_projects
    - run rails cats:grn_import:import
