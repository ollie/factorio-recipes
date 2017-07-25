class Ingredient
  attr_accessor :name, :amount, :recipe

  def self.new_from_prototype(data, prototypes)
    new.tap do |instance|
      instance.name   = data.fetch(:name)
      instance.amount = data.fetch(:amount)
      prototype       = prototypes.find { |p| p.name == instance.name }
      instance.recipe = Recipe.new_from_prototype(prototype, prototypes)
    end
  end
end
