class AddMemberInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :status, :integer, default: 0
    add_column :members, :has_patch, :boolean, default: false
    add_column :members, :section_lead, :boolean, default: false
    add_column :members, :section, :integer, default: 0
    add_column :members, :has_bus_insurance, :boolean, default: false
    add_column :members, :gigo_key, :string
    add_column :members, :data, :jsonb, default: {}, null: false

    add_index :members, :data, using: :gin
  end
end
