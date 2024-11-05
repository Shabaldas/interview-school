class AddEmailToStudents < ActiveRecord::Migration[7.2]
  def change
    add_column :students, :email, :string
    add_index :students, :email, unique: true
  end
end
