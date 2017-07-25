class Prototype
  attr_accessor :values

  def initialize(data, recipe_names)
    self.values = {}.tap do |hash|
      hash[:name]              = data.fetch(:name)
      hash[:time]              = data.fetch(:time).to_f
      hash[:amount]            = data[:amount] || 1
      hash[:amount_per_second] = hash.fetch(:amount) / hash.fetch(:time)
      hash[:ingredients]       = data.fetch(:ingredients).map do |ingredient|
        ingredient_name = ingredient.fetch(:name)

        unless recipe_names.include?(ingredient_name)
          abort "Recipe not found: #{ingredient_name.inspect} (in #{data.fetch(:name).inspect})"
        end

        {
          name:   ingredient_name,
          amount: ingredient[:amount] || 1
        }
      end
    end
  end

  def name
    values.fetch(:name)
  end

  def time
    values.fetch(:time)
  end

  def amount
    values.fetch(:amount)
  end

  def amount_per_second
    values.fetch(:amount_per_second)
  end

  def ingredients
    values.fetch(:ingredients)
  end
end
