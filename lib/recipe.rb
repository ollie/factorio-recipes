require_relative 'ingredient'

class Recipe
  attr_accessor :name, :time, :amount, :amount_per_second, :ingredients

  def self.new_from_prototype(prototype, prototypes)
    new.tap do |instance|
      instance.name              = prototype.name
      instance.time              = prototype.time
      instance.amount            = prototype.amount
      instance.amount_per_second = prototype.amount_per_second

      instance.ingredients = prototype.ingredients.map do |prototype_ingredient|
        Ingredient.new_from_prototype(prototype_ingredient, prototypes)
      end
    end
  end
end
