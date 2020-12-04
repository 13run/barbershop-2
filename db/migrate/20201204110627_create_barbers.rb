class CreateBarbers < ActiveRecord::Migration[6.0]
  def change
    create_table :barbers do |t|
      t.text :name
    
      t.timestamps
    end

    Barber.create name: 'Jessy Pinckman'
    Barber.create name: 'Walter White'
    Barber.create name: 'Gus Fring'
    
  end
end
