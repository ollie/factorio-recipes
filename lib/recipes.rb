require_relative 'prototype'
require_relative 'recipe'

class Recipes
  def self.all
    @recipes ||= begin
      raw_recipes  = MultiJson.load(File.read('data/recipes.json'), symbolize_keys: true)
      recipe_names = raw_recipes.map { |recipe| recipe.fetch(:name) }
      prototypes   = raw_recipes.map { |recipe| Prototype.new(recipe, recipe_names) }.deep_freeze!

      recipes = prototypes.map { |prototype| Recipe.new_from_prototype(prototype, prototypes) }.deep_freeze!
      recipes
    end
  end

  def self.find(name)
    all.find { |r| r.name == name }
  end

  def self.find!(name)
    find(name) || raise("Unknown recipe: #{name.inspect}")
  end
end
