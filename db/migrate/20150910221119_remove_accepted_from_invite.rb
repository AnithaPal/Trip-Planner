class RemoveAcceptedFromInvite < ActiveRecord::Migration
  def change
    remove_column :invites, :accepted, :boolean
  end
end
