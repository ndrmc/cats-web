# == Schema Information
#
# Table name: postings
#
#  id                  :integer          not null, primary key
#  posting_code        :uuid
#  document_type       :integer
#  document_id         :integer
#  posted              :boolean
#  reversed_posting_id :integer
#  posting_type        :integer
#  created_by          :integer
#  modified_by         :integer
#  deleted             :boolean          default(FALSE)
#  deleted_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Posting < ApplicationRecord
    enum posting_type: {
        normal: 0,
        reversed: 1,
        reversal: 2,
        inventory: 3
    }
    enum document_type: {
        receipt: 0,
        dispatch: 1,
        delivery: 2,
        project: 3,
        stoke_take:4
    }   

    has_many :posting_items

end
