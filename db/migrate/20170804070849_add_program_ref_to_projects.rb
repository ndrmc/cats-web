class AddProgramRefToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :program, foreign_key: true
  end
end
