require 'bundler'
Bundler.require

require 'ice_nine/core_ext/object'
require_relative 'lib/recipe'

# Print recipe
def pr(recipe, level: 1)
  indent = '  ' * (level - 1)

  puts "#{indent}#{recipe.fetch(:amount)} #{recipe.fetch(:name)}"

  recipe.fetch(:ingredients).each do |ingredient|
    pr(ingredient, level: level + 1)
  end

  return unless recipe[:raws]

  puts
  recipe[:raws].each do |name, amount|
    puts "#{amount} #{name}"
  end
end

################
# Resource trees
################

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
# pr Recipe.calculate('Offshore pump', 1)
# pr Recipe.calculate('Offshore pump', 1)

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
# pr Recipe.calculate('Assembling machine 2', 1)

# 1 Science pack 1
#   1 Copper plate
#   1 Iron gear wheel
#     1*4=4 Iron plate
#
# 4 Iron plate
# 1 Copper plate
# pr Recipe.calculate('Science pack 1', 1)

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
# pr Recipe.calculate('Science pack 2', 1)

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
# pr Recipe.calculate('Military science pack', 1)

#####################
# Totals and Machines
#####################

# Yellow belt: 13.333 i/s
# Red belt:    26.667 i/s
# Blue belt:   40 i/s
#
# Miner new
# Iron, Copper, Coal: 0.525 i/s
# Stone:              0.65 i/s
#
# Steel/Electric furnace
# Iron, Copper, Stone: 0.5714 i/s (1.75 s/i)
# Steel:               0.0572     (17.5 s/i)
#
# Assembly 2: Crafting speed: 0.75

def pt(label, totals)
  puts "  #{label}"
  totals.sort.each { |name, amount| puts "    #{name}: #{amount}" }
end

def woo(recipe_names, amount)
  total_machines = {}
  total_smelters = {}
  total_miners   = {}

  recipe_names.each do |recipe_name|
    puts "#{amount} #{recipe_name}"
    tree     = Recipe.tree(recipe_name, amount)
    totals   = Recipe.totals(tree)
    machines = Recipe.machines(totals)
    smelters = Recipe.smelters(totals)
    miners   = Recipe.miners(totals)
    pt 'Totals:', totals
    pt 'Machines:', machines
    pt 'Smelters:', smelters
    pt 'Miners:', miners
    puts

    machines.each { |name, amount| total_machines[name] ||= 0; total_machines[name] += amount }
    smelters.each { |name, amount| total_smelters[name] ||= 0; total_smelters[name] += amount }
    miners.each   { |name, amount| total_miners[name]   ||= 0; total_miners[name]   += amount }
  end

  puts '-----------'
  puts
  puts 'Grand total:'
  puts '  Machines:'
  total_machines.sort.each { |name, amount| puts "    #{name}: #{amount}" }
  puts '  Smelters:'
  total_smelters.sort.each { |name, amount| puts "    #{name}: #{amount}" }
  puts '  Miners:'
  total_miners.sort.each   { |name, amount| puts "    #{name}: #{amount}" }
end

woo(
  [
    'Science pack 1',
    'Science pack 2',
    'Military science pack'
  ],
  2
)
