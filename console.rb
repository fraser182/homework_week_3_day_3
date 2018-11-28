require_relative('models/bounty.rb')

bounty1 = Bounty.new({
  'name' => 'Darth Sidious',
  'species' => 'Sith',
  'danger_level' => 'high',
  'bounty_value' => '1000000'
  })

  bounty2 = Bounty.new({
    'name' => 'Darth Maul',
    'species' => 'Red Potato',
    'danger_level' => 'medium',
    'bounty_value' => '500000'
    })

    bounty3 = Bounty.new({
      'name' => 'Darth Vader',
      'species' => 'Robot',
      'danger_level' => 'medium',
      'bounty_value' => '750000'
      })

      bounty4 = Bounty.new({
        'name' => 'Kylo Ren',
        'species' => 'Human',
        'danger_level' => 'low',
        'bounty_value' => '50'
        })

bounty1.save
bounty2.save
bounty3.save
bounty4.save

bounty4.bounty_value = '1000'
bounty4.update

# bounty3.delete

Bounty.find_by_name("Darth Maul")
