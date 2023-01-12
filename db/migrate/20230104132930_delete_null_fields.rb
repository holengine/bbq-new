class DeleteNullFields < ActiveRecord::Migration[7.0]
  change_table :subscriptions do |t|
    t.change :user_id, :integer, null: true, default: ''
  end

  change_table :comments do |t|
    t.change :user_id, :integer, null: true, default: ''
  end
end
