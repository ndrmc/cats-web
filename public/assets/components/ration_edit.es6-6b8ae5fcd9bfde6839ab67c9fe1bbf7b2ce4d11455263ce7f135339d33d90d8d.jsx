class RationEdit extends React.Component {
  
  render() {
    return (
      <div className="wrapper wrapper-content">
        <div>
          <form action="#" className="form-horizontal" role="form">
            <div>
              <div className="ibox">
                <div className="ibox-title">
                  <h5>Basic information</h5>
                </div>

                <div className="ibox-content">

                  <div className="form-group form-group-lg">
                    <label htmlFor="ration_reference_no" className="col-sm-2 control-label">Reference No</label>
                    <div className="col-sm-8">
                      <input id="ration_reference_no" type="text" className="form-control"></input>
                    </div>
                  </div>

                  <div className="form-group">
                    <label htmlFor="ration_title" className="col-sm-2 control-label">Title</label>
                    <div className="col-sm-8">
                      <input id="ration_title" type="text" className="form-control"></input>
                    </div>
                  </div>

                  <div className="form-group">
                    <label htmlFor="ration_created_date" className="col-sm-2 control-label">Created Date</label>
                    <div className="col-sm-8">
                      <input id="ration_created_date" type="text" className="form-control"></input>
                    </div>
                  </div>

                  <div className="form-group">
                    <label htmlFor="ration_program_id" className="col-sm-2 control-label">Program</label>
                    <div className="col-sm-8">
                      <select name="program" id="ration_program_id" className="form-control">
                        <option value="relief">Relief</option>
                        <option value="psnp">PSNP</option>
                        <option value="idp">IDPs</option>
                        <option value="other">Other</option>
                      </select>
                    </div>
                  </div>

                  <div className="form-group">
                    <label htmlFor="ration_remark" className="col-sm-2 control-label">Remark</label>
                    <div className="col-sm-8">
                      <textarea id="ration_remark" type="text" className="form-control"></textarea>
                    </div>
                  </div>


                </div>

                <div className="ibox-title">
                  <h5>Ration Items (Commodities)</h5>
                </div>

                <div className="ibox-content">
                  
                </div>

              </div>

              <div className="actions">
                <button className="btn btn-primary" type="submit">Save Ration</button>
              </div>

            </div>
          </form>

        </div>

      </div>
    )
  }
}

