class AddFirtsRoles < ActiveRecord::Migration[7.0]
  def change
    Role.create(name: "Super Administrador", code: "superadmin")
    Role.create(name: "Administrador", code: "admin")
    Role.create(name: "Consolidación", code: "consolidation")
    Role.create(name: "Editor", code: "editor")
  end
end
