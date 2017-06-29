class DispatchReportDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      location: { source: "DispatchReport.location", cond: :like, searchable: true, orderable: true },
      requisition:  { source: "DispatchReport.requisition",  cond: :like },
      commodity:        { source: "DispatchReport.commodity" },
      allocated:        { source: "DispatchReport.allocated" },
      dispatched:        { source: "DispatchReport.dispatched" },
      operation_id:        { source: "DispatchReport.operation_id" },
      region_id:        { source: "DispatchReport.region_id" },
      location_id:        { source: "DispatchReport.location_id" }
    }
  end

  def data
    records.map do |record|
      {
        location: record.location,
        requisition:  record.requisition,
        commodity:        record.commodity,
        allocated: record.allocated,
        dispatched:  record.dispatched,
        progress:        record.dispatch / record.allocated  ,
        # 'DT_RowId' => record.id, # This will set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  private

  def get_raw_records
      Reports.new.dispatch_reports_by_fdp @operation
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
