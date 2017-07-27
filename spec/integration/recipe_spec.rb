require 'spec_helper'

RSpec.describe Recipe do
  context 'tree' do
    # 1 Offshore pump
    #   2 Electronic circuit
    #     2*2=4 Iron plate
    #     2*10=20 Copper cable
    #       20*1/2=10 Copper plate
    #   1 Pipe
    #     1*2=2 Iron plate
    #   1 Iron gear wheel
    #     1*4=4 Iron plate
    #
    # 10 Iron plate
    # 10 Copper plate
    it '1 Offshore pump' do
      actual = Recipe.tree('Offshore pump', 1)
      expected = {
        amount: 1,
        name: 'Offshore pump',
        ingredients: [
          {
            amount: 2,
            name: 'Electronic circuit',
            ingredients: [
              {
                amount: 4,
                name: 'Iron plate',
                ingredients: []
              },
              {
                amount: 20,
                name: 'Copper cable',
                ingredients: [
                  {
                    amount: 10,
                    name: 'Copper plate',
                    ingredients: []
                  }
                ]
              }
            ]
          },
          {
            amount: 1,
            name: 'Pipe',
            ingredients: [
              {
                amount: 2,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          },
          {
            amount: 1,
            name: 'Iron gear wheel',
            ingredients: [
              {
                amount: 4,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          }
        ],
        # raws: {
        #   'Iron plate' => 10,
        #   'Copper plate' => 10
        # }
      }

      expect(actual).to eq(expected)
    end

    # 5 Offshore pump
    #   5*2=10 Electronic circuit
    #     10*2=20 Iron plate
    #     10*10=100 Copper cable
    #       100*1/2=50 Copper plate
    #   5*1=5 Pipe
    #     5*2=10 Iron plate
    #   5*1=5 Iron gear wheel
    #     5*4=20 Iron plate
    #
    # 50 Iron plate
    # 50 Copper plate
    it '5 Offshore pump' do
      actual = Recipe.tree('Offshore pump', 5)
      expected = {
        amount: 5,
        name: 'Offshore pump',
        ingredients: [
          {
            amount: 10,
            name: 'Electronic circuit',
            ingredients: [
              {
                amount: 20,
                name: 'Iron plate',
                ingredients: []
              },
              {
                amount: 100,
                name: 'Copper cable',
                ingredients: [
                  {
                    amount: 50,
                    name: 'Copper plate',
                    ingredients: []
                  }
                ]
              }
            ]
          },
          {
            amount: 5,
            name: 'Pipe',
            ingredients: [
              {
                amount: 10,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          },
          {
            amount: 5,
            name: 'Iron gear wheel',
            ingredients: [
              {
                amount: 20,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          }
        ],
        # raws: {
        #   'Iron plate' => 50,
        #   'Copper plate' => 50
        # }
      }

      expect(actual).to eq(expected)
    end

    # 1 Assembling machine 2
    #   20 Iron plate
    #   5 Electronic circuit
    #     5*2=10 Iron plate
    #     5*10=50 Copper cable
    #       50*1/2=25 Copper plate
    #   10 Iron gear wheel
    #     10*4=40 Iron plate
    #   1 Assembling machine 1
    #     3 Electronic circuit
    #       3*2=6 Iron plate
    #       3*10=30 Copper cable
    #         30*1/2=15 Copper plate
    #     5 Iron gear wheel
    #       5*4=20 Iron plate
    #     9 Iron plate
    #
    # 105 Iron plate
    # 40 Copper plate
    it '1 Assembling machine 2' do
      actual = Recipe.tree('Assembling machine 2', 1)
      expected = {
        amount: 1,
        name: 'Assembling machine 2',
        ingredients: [
          {
            amount: 20,
            name: 'Iron plate',
            ingredients: []
          },
          {
            amount: 5,
            name: 'Electronic circuit',
            ingredients: [
              {
                amount: 10,
                name: 'Iron plate',
                ingredients: []
              },
              {
                amount: 50,
                name: 'Copper cable',
                ingredients: [
                  {
                    amount: 25,
                    name: 'Copper plate',
                    ingredients: []
                  }
                ]
              }
            ]
          },
          {
            amount: 10,
            name: 'Iron gear wheel',
            ingredients: [
              {
                amount: 40,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          },
          {
            amount: 1,
            name: 'Assembling machine 1',
            ingredients: [
              {
                amount: 3,
                name: 'Electronic circuit',
                ingredients: [
                  {
                    amount: 6,
                    name: 'Iron plate',
                    ingredients: []
                  },
                  {
                    amount: 30,
                    name: 'Copper cable',
                    ingredients: [
                      {
                        amount: 15,
                        name: 'Copper plate',
                        ingredients: []
                      }
                    ]
                  }
                ]
              },
              {
                amount: 5,
                name: 'Iron gear wheel',
                ingredients: [
                  {
                    amount: 20,
                    name: 'Iron plate',
                    ingredients: []
                  }
                ]
              },
              {
                amount: 9,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          }
        ],
        # raws: {
        #   'Iron plate' => 105,
        #   'Copper plate' => 40
        # }
      }

      expect(actual).to eq(expected)
    end

    # 1 Science pack 1
    #   1 Copper plate
    #   1 Iron gear wheel
    #     1*4=4 Iron plate
    #
    # 4 Iron plate
    # 1 Copper plate
    it '1 Science pack 1' do
      actual = Recipe.tree('Science pack 1', 1)
      expected = {
        amount: 1,
        name: 'Science pack 1',
        ingredients: [
          {
            amount: 1,
            name: 'Copper plate',
            ingredients: []
          },
          {
            amount: 1,
            name: 'Iron gear wheel',
            ingredients: [
              {
                amount: 4,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          }
        ],
        # raws: {
        #   'Copper plate' => 1,
        #   'Iron plate' => 4
        # }
      }

      expect(actual).to eq(expected)
    end

    # 1 Science pack 2
    #   1 Inserter
    #     1 Electronic circuit
    #       1*2=2 Iron plate
    #       1*10=10 Copper cable
    #         10*1/2=5 Copper plate
    #     1 Iron gear wheel
    #       1*4=4 Iron plate
    #     1 Iron plate
    #   1 Transport belt
    #     1/2*1=1/2 Iron plate
    #     1/2*1=1/2 Iron gear wheel
    #       1/2*4=2 Iron plate
    #
    # 9.5 Iron plate
    # 5 Copper plate
    it '1 Science pack 2' do
      actual = Recipe.tree('Science pack 2', 1)
      expected = {
        amount: 1,
        name: 'Science pack 2',
        ingredients: [
          {
            amount: 1,
            name: 'Inserter',
            ingredients: [
              {
                amount: 1,
                name: 'Electronic circuit',
                ingredients: [
                  {
                    amount: 2,
                    name: 'Iron plate',
                    ingredients: []
                  },
                  {
                    amount: 10,
                    name: 'Copper cable',
                    ingredients: [
                      {
                        amount: 5,
                        name: 'Copper plate',
                        ingredients: []
                      }
                    ]
                  }
                ]
              },
              {
                amount: 1,
                name: 'Iron gear wheel',
                ingredients: [
                  {
                    amount: 4,
                    name: 'Iron plate',
                    ingredients: []
                  }
                ]
              },
              {
                amount: 1,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          },
          {
            amount: 1,
            name: 'Transport belt',
            ingredients: [
              {
                amount: 0.5,
                name: 'Iron plate',
                ingredients: []
              },
              {
                amount: 0.5,
                name: 'Iron gear wheel',
                ingredients: [
                  {
                    amount: 2,
                    name: 'Iron plate',
                    ingredients: []
                  }
                ]
              }
            ]
          }
        ],
        # raws: {
        #   'Iron plate' => 9.5,
        #   'Copper plate' => 5
        # }
      }

      expect(actual).to eq(expected)
    end

    # 1 Military science pack
    #   1/2*1=1/2 Piercing rounds magazine
    #     1/2*1=1/2 Firearm magazine
    #       1/2*4=2 Iron plate
    #     1/2*1=1/2 Steel plate
    #     1/2*5=5/2 Copper plate
    #   1/2*1=1/2 Grenade
    #     1/2*5=5/2 Iron plate
    #     1/2*10=5 Coal
    #   1/2*1=1/2 Gun turret
    #     1/2*10=5 Iron gear wheel
    #       5*4=20 Iron plate
    #     1/2*10=5 Copper plate
    #     1/2*20=10 Iron plate
    #
    # 5 Coal
    # 34.5 Iron plate (39.5 if Steel's Iron plates are included)
    # 7.5 Copper plate
    # 0.5 Steel plate
    it '1 Military science pack' do
      actual = Recipe.tree('Military science pack', 1)
      expected = {
        amount: 1,
        name: 'Military science pack',
        ingredients: [
          {
            amount: 0.5,
            name: 'Piercing rounds magazine',
            ingredients: [
              {
                amount: 0.5,
                name: 'Firearm magazine',
                ingredients: [
                  {
                    amount: 2,
                    name: 'Iron plate',
                    ingredients: []
                  }
                ]
              },
              {
                amount: 0.5,
                name: 'Steel plate',
                ingredients: [
                  {
                    amount: 5,
                    name: 'Iron plate',
                    ingredients: []
                  }
                ]
              },
              {
                amount: 2.5,
                name: 'Copper plate',
                ingredients: []
              }
            ]
          },
          {
            amount: 0.5,
            name: 'Grenade',
            ingredients: [
              {
                amount: 2.5,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          },
          {
            amount: 0.5,
            name: 'Gun turret',
            ingredients: [
              {
                amount: 5,
                name: 'Iron gear wheel',
                ingredients: [
                  {
                    amount: 20,
                    name: 'Iron plate',
                    ingredients: []
                  }
                ]
              },
              {
                amount: 5,
                name: 'Copper plate',
                ingredients: []
              },
              {
                amount: 10,
                name: 'Iron plate',
                ingredients: []
              }
            ]
          }
        ],
        # raws: {
        #   'Iron plate' => 39.5,
        #   'Steel plate' => 0.5,
        #   'Copper plate' => 7.5
        # }
      }

      expect(actual).to eq(expected)
    end
  end
end
