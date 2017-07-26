require 'bundler'
Bundler.require

require 'ice_nine/core_ext/object'
require_relative 'lib/recipes'

def print_recipes(recipes, level: 1)
  indent = '  ' * (level - 1)

  recipes.each do |recipe|
    puts "#{indent}#{recipe.amount} #{recipe.name}"

    if recipe.ingredients.any?
      print_recipes(recipe.ingredients, level: level + 1)
    end
  end
end

# print_recipes([Recipes.all[7]])

# print_recipes([Recipes.find!('Assembling machine 2')])
# Iron plate: 105
# Copper plate: 40

print_recipes([Recipes.find!('Offshore pump')])
# Iron plate: 10
# Copper plate: 10
