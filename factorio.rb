require 'bundler'
Bundler.require

require 'ice_nine/core_ext/object'
require_relative 'lib/recipes'

def print_recipes(recipes, level: 1)
  recipes.each do |recipe|
    print_recipe(recipe, level: level)
    puts
    puts
    puts
  end
end

def print_recipe(recipe, level:)
  indent = '    ' * (level - 1)

  puts "#{indent}Name:    #{recipe.name}"
  puts "#{indent}Time:    #{recipe.time}"
  puts "#{indent}Amount:  #{recipe.amount}"
  puts "#{indent}Amount/s #{recipe.amount_per_second}"

  if recipe.ingredients.any?
    puts "#{indent}Ingredients:"
    print_ingredients(recipe.ingredients, level: level + 1)
  end
end

def print_ingredients(ingredients, level:)
  indent = '    ' * (level - 1)

  ingredients.each do |ingredient|
    puts
    puts "#{indent}Amount:  #{ingredient.amount}"
    print_recipe(ingredient.recipe, level: level)
  end
end

# require 'pp'
# print_recipes([Recipes.all[4]])
print_recipes(Recipes.all)
