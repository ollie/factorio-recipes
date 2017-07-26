class Recipe
  attr_accessor :name, :time, :amount, :amount_per_second, :ingredients

  def self.new_from_prototype(prototype, prototypes, amount: 1)
    new.tap do |recipe|
      recipe.name              = prototype.name
      recipe.time              = prototype.time
      recipe.amount            = prototype.amount * amount
      recipe.amount_per_second = prototype.amount_per_second

      recipe.ingredients = prototype.ingredients.map do |ingredient|
        name   = ingredient.fetch(:name)
        amount = ingredient.fetch(:amount)
        ingredient_prototype = prototypes.find { |p| p.name == name }.dup

        # require 'pry'; binding.pry
        # 'a'

        Recipe.new_from_prototype(ingredient_prototype, prototypes, amount: amount)
      end
    end
  end
end
