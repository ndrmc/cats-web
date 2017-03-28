require 'terminal-table'

namespace :cats do
    namespace :migrate do
      desc "Migrates adminunit records from v1 database to refactored location hierarchy based on ancestry gem path-enumeration pattern"
      task location: :environment do
      puts "Started migration of AdminUnit records"

      table = Terminal::Table.new :headings=> ['Step','Total records', 'Migrated records', 'Failed records']

      updated = 0
      # Iterate over all records and update parent_id field with parent_node_id
      # TOTO: update admin_unit type betweeen AdminUnit and Locaiton table
      Location.all.each do |l|
        l.parent_id = l.parent_node_id
        l.save
        updated += 1
      end

      rows = []
      rows << ['AdminUnit', Location.count,updated, Location.count - updated]
      rows << ['Location', Location.count, updated, Location.count - updated]

      table.rows = rows
      puts table

      puts "Completed migration of AdminUnit records to Location hierarchy"
    end
  end
    namespace :fdp do
      desc "Updates region, zone and woreda fields for all FDPs"
      task update_locations: :environment do
        puts "Started update ..."

        # Iterate over all records and save again (triggers before_save method and updates the fields)
        Fdp.all.each do |l|
          l.save
        end



        puts "Completed update"
      end
    end
end
