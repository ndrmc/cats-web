To import receipt, dispatch and delivery records from grn_imports, git_imports and delivery_imports tables, respectively,
follow the following steps

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

After this 
    - run rails cats:data_import:update_projects

To clean the data before import:
    -run all statements in 
        db/scripts/data_for_import.sql
        db/scripts/git_imports.sql 
        db/scripts/grn_imports.sql and
        db/scripts/delivery_imports.sql  on the database

Now all the data is cleaned up and can be imported. 
And finally, 
    -to import grn records,
        run rails cats:grn_import:import
    -to import gin records,
        run rails cats:gin_import:import
    -to import grn records,
        run rails cats:delivery_import:import