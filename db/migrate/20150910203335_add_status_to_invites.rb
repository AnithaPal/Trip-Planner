class AddStatusToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :status, :string, default: 'sent'
  end
end
